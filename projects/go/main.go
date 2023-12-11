package main

import (
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"wbm/controller"
	"wbm/lib"
)

func main() {
	lib.InitMysql()
	router := mux.NewRouter()

	/* Do not serve static files during benchmarking */
	// router.PathPrefix("/public/").Handler(http.StripPrefix("/public/", http.FileServer(http.Dir("./public"))))

	router.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		http.Redirect(w, r, "/record", http.StatusMovedPermanently)
	}).Methods("GET")

	adminRouter := router.PathPrefix("/record").Subrouter()
	adminRouter.HandleFunc("", controller.Record).Methods("GET")
	adminRouter.HandleFunc("delete", controller.RecordDelete).Methods("POST")

	log.SetFlags(0)
	log.Println("[INFO] Listening on 127.0.0.1:8080...")
	http.ListenAndServe("127.0.0.1:8080", router)
}
