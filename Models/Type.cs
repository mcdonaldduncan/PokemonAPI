using System.Text.Json.Serialization;

namespace PokemonAPI.Models
{
    public class Type
    {
        [JsonPropertyName("Name")]
        public string Name { get; set; }

        [JsonPropertyName("HexColor")]
        public string HexColor { get; set; }
    }
}
