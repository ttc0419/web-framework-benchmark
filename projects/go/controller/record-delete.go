package controller

import (
	"net/http"
	"wbm/lib"
)

func RecordDelete(w http.ResponseWriter, r *http.Request) {
	session, err := lib.Session.Get(r, "main")
	if err != nil || r.FormValue("_csrf") != session.Values["Csrf"].(string) {
		w.WriteHeader(http.StatusForbidden)
		w.Write([]byte("Invalid CSRF Token"))
	} else {
		println("Deleting record " + r.FormValue("id") + "...")
		http.Redirect(w, r, "/record", http.StatusFound)
	}
}
