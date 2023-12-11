namespace wbm.Models
{
    public record struct RecordModel
    {
        public RecordModel(uint id, string name, string artist, uint year, uint numberOfDiscs, uint genreId, string genreName)
        {
            this.id = id;
            this.name = name;
            this.artist = artist;
            this.year = year;
            this.numberOfDiscs = numberOfDiscs;
            this.genreId = genreId;
            this.genreName = genreName;
        }

        public uint id;
        public string name;
        public string artist;
        public uint year;
        public uint numberOfDiscs;
        public uint genreId;
        public string genreName;
    }
}
