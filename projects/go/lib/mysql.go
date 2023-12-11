package lib

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
	"log"
)

var Database *sql.DB = nil

func InitMysql() {
	var err error
	Database, err = sql.Open("mysql", "wbm:wbm@tcp(127.0.0.1:3306)/wbm")
	if err != nil {
		log.Panic("[FATAL] Cannot connect to MySQL!\n", err.Error())
	}
}
