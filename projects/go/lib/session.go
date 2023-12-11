package lib

import "github.com/gorilla/sessions"

var Session sessions.Store = sessions.NewCookieStore([]byte("wbm"))
