namespace wbm.Models
{
    public record struct GenreModel
    {
        public GenreModel(uint id, string name)
        {
            this.id = id;
            this.name = name;
        }

        public uint id;
        public string name;
    }
}
