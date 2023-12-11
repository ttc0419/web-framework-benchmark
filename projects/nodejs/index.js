const express = require('express');
const session = require('express-session');
const csrf = require('csurf');
const mysql = require('mysql2/promise');

const PORT = 8080;

/* MySQL connection pool */
const db = mysql.createPool({
    host: '127.0.0.1',
    user: 'wbm',
    password: 'wbm',
    database: 'wbm',
    waitForConnections: true,
    connectionLimit: 16,
    queueLimit: 0
});

/* App configuration */
const app = express();
app.set('view engine', 'eta');

/* Middlewares */
// app.use(express.static('public'));
app.use(express.urlencoded({extended: false}));
app.use(session({
    secret: 'wbm',
    resave: false,
    saveUninitialized: false
}));
app.use(csrf(undefined));

/* Routes */
app.get('/', function(request, response) {
    response.writeHead(301, {'Location': '/record'});
    response.end();
});

app.get('/record', async function(request, response) {
    const [genres] = await db.query("SELECT * FROM `genres`");
    let viewParams = {'genres': genres, '_csrf': request.csrfToken()};

    if (Object.keys(request.query).length !== 0) {
        if (request.query.year !== undefined && request.query.year !== '' && !/^\d+$/.test(request.query.year) || request.query.genre !== undefined && request.query.genre !== '' && !/^\d+$/.test(request.query.genre)) {
            response.status(400).send();
            return
        }

        let sqlParams = [];
        let sql = "SELECT `records`.*, `genres`.`name` AS `genre_name` " +
            "FROM records INNER JOIN genres ON records.genre_id = genres.id " +
            "WHERE 1=1";

        if (request.query.name !== undefined && request.query.name !== '') {
            sql += " AND records.name LIKE ?";
            sqlParams.push(`%${request.query.name}%`);
        }

        if (request.query.artist !== undefined && request.query.artist !== '') {
            sql += " AND records.artist LIKE ?";
            sqlParams.push(`%${request.query.artist}%`);
        }

        if (request.query.year !== undefined && request.query.year !== '') {
            sql += " AND records.year <= ?";
            sqlParams.push(request.query.year);
        }

        if (request.query.genre !== undefined && request.query.genre !== '') {
            sql += " AND records.genre_id = ?";
            sqlParams.push(request.query.genre);
        }

        const [records] = await db.query(sql, sqlParams);
        viewParams.records = records;
    }

    response.render('record/index', viewParams);
});

app.post('/record/delete', function (request, response) {
    console.log(`Deleting record ${request.body.id}...`);
    response.writeHead(301, {'Location': '/record'});
    response.end();
});

/* Start the app */
app.listen(PORT);
console.log(`Server is listening on port http://127.0.0.1:${PORT}`);
