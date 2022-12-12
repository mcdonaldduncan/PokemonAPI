using System.Text.Json.Serialization;

namespace PokemonAPI.Models
{
    public class DataModel
    {
        [JsonPropertyName("X")]
        public string X { get; set; }

        [JsonPropertyName("Y")]
        public int Y { get; set; }

    }
}
