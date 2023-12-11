using System.Text;
using Microsoft.AspNetCore.Mvc;
using MySqlConnector;
using wbm.Models;

namespace wbm.Controllers
{
    public class RecordController : Controller
    {
        private readonly IConfiguration configuration;
        private readonly ILogger<RecordController> logger;

        public RecordController(IConfiguration configuration, ILogger<RecordController> logger)
        {
            this.configuration = configuration;
            this.logger = logger;
        }

        public async Task<IActionResult> Index(string name, string artist, int? year, int? genre)
        {
            using MySqlConnection mysql = new MySqlConnection(configuration["MysqlConnectionString"]);
            await mysql.OpenAsync();
            ViewData["mysql"] = mysql;

            MySqlCommand genresCommand = mysql.CreateCommand();
            genresCommand.CommandText = @"SELECT * FROM `genres`";
            MySqlDataReader genresReader = await genresCommand.ExecuteReaderAsync();

            List<GenreModel> genres = new List<GenreModel>();
            while (genresReader.Read())
                genres.Add(new GenreModel(genresReader.GetUInt32("id"), genresReader.GetString("name")));
            ViewData["genres"] = genres;

            await genresReader.CloseAsync();
            await genresCommand.DisposeAsync();

            if (Request.QueryString.HasValue)
            {
                if (string.IsNullOrEmpty(name) && string.IsNullOrEmpty(artist) && year == null && genre == null)
                {
                    return BadRequest();
                }

                using MySqlCommand recordsCommand = mysql.CreateCommand();
                List<string> sqlParams = new List<string>();
                StringBuilder sql = new StringBuilder("SELECT `records`.*, `genres`.`name` AS `genre_name` FROM records INNER JOIN genres ON records.genre_id = genres.id WHERE 1=1");

                if (!string.IsNullOrEmpty(name))
                {
                    sql.Append(" AND records.name LIKE @name");
                    recordsCommand.Parameters.AddWithValue("@name", $"%{name}%");
                }

                if (!string.IsNullOrEmpty(artist))
                {
                    sql.Append(" AND records.artist LIKE @artist");
                    recordsCommand.Parameters.AddWithValue("@artist", $"%{artist}%");
                }

                if (year != null)
                {
                    sql.Append(" AND records.year <= @year");
                    recordsCommand.Parameters.AddWithValue("@year", year);
                }

                if (genre != null)
                {
                    sql.Append(" AND records.genre_id = @genre_id");
                    recordsCommand.Parameters.AddWithValue("@genre_id", genre);
                }

                recordsCommand.CommandText = sql.ToString();
                using MySqlDataReader recordsReader = await recordsCommand.ExecuteReaderAsync();
                List<RecordModel> records = new List<RecordModel>();
                while (recordsReader.Read())
                    records.Add(new RecordModel(recordsReader.GetUInt32("id"), recordsReader.GetString("name"),
                        recordsReader.GetString("artist"), recordsReader.GetUInt32("year"), recordsReader.GetUInt32("number_of_discs"),
                        recordsReader.GetUInt32("genre_id"), recordsReader.GetString("genre_name")));
                ViewData["records"] = records;
            }

            return View();
        }

        public IActionResult Delete(uint id)
        {
            if (Request.Method != "POST")
            {
                return StatusCode(405);
            }

            logger.Log(LogLevel.Information, $"Deleting record {id}...");
            return RedirectToActionPermanent(controllerName: "Record", actionName: "Index");
        }
    }
}
