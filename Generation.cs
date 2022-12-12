using System.Text.Json.Serialization;

namespace PokemonAPI
{
    public class Generation
    {
        [JsonPropertyName("Generation_Number")]
        public int Generation_Number { get; set; }

        [JsonPropertyName("Region_Name")]   
        public string Region_Name { get; set; }

    }
}
