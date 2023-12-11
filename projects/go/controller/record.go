package controller

import (
	"crypto/rand"
	"database/sql"
	"encoding/base64"
	"github.com/gorilla/sessions"
	"html/template"
	"net/http"
	"regexp"
	"wbm/lib"
	"wbm/model"
	"wbm/view"
)

type RecordViewData struct {
	Csrf    string
	Genres  []model.Genre
	Records *[]model.Record
}

func Record(w http.ResponseWriter, r *http.Request) {
	vd := RecordViewData{
		Csrf:    "",
		Genres:  make([]model.Genre, 0),
		Records: nil,
	}
	genreResults, err := lib.Database.Query("SELECT * FROM genres")
	defer genreResults.Close()
	if err != nil {
		println(err.Error())
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
	for genreResults.Next() {
		var genre model.Genre
		genreResults.Scan(&genre.Id, &genre.Name)
		vd.Genres = append(vd.Genres, genre)
	}

	queryParameters := r.URL.Query()
	if len(queryParameters) > 0 {
		uintRegex := regexp.MustCompile("^[0-9]+$")
		if queryParameters.Get("year") != "" && !uintRegex.MatchString(queryParameters.Get("year")) || queryParameters.Get("genre") != "" && !uintRegex.MatchString(queryParameters.Get("genre")) {
			w.WriteHeader(http.StatusBadRequest)
			return
		}

		var session *sessions.Session
		session, err = lib.Session.Get(r, "main")
		if err != nil || session.Values["Csrf"] == nil {
			bytes := make([]byte, 15)
			rand.Read(bytes)
			session.Values["Csrf"] = base64.URLEncoding.EncodeToString(bytes)
			session.Save(r, w)
		}
		vd.Csrf = session.Values["Csrf"].(string)

		var sqlParam []interface{}
		recordSql := "SELECT `records`.*, `genres`.`name` AS `genre_name` " +
			"FROM records INNER JOIN genres ON records.genre_id = genres.id " +
			"WHERE 1=1"

		if queryParameters.Get("name") != "" {
			recordSql += " AND records.name LIKE ?"
			sqlParam = append(sqlParam, "%"+queryParameters.Get("name")+"%")
		}

		if queryParameters.Get("artist") != "" {
			recordSql += " AND records.artist LIKE ?"
			sqlParam = append(sqlParam, queryParameters.Get("artist")+"%")
		}

		if queryParameters.Get("year") != "" {
			recordSql += " AND records.year <= ?"
			sqlParam = append(sqlParam, queryParameters.Get("year"))
		}

		if queryParameters.Get("genre") != "" {
			recordSql += " AND records.genre_id = ?"
			sqlParam = append(sqlParam, queryParameters.Get("genre"))
		}

		var recordResults *sql.Rows
		recordResults, err = lib.Database.Query(recordSql, sqlParam...)
		defer recordResults.Close()
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			return
		}
		vd.Records = new([]model.Record)
		for recordResults.Next() {
			var record model.Record
			recordResults.Scan(&record.Id, &record.GenreId, &record.Name,
				&record.Artist, &record.Year, &record.NumberOfDiscs, &record.GenreName)
			*vd.Records = append(*(vd.Records), record)
		}
	}

	t, _ := template.ParseFS(view.Templates, "record/index.gohtml", "layout/main.gohtml")
	err = t.Execute(w, vd)
}
