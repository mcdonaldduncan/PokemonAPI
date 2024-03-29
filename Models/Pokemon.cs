﻿using System.Text.Json.Serialization;

namespace PokemonAPI.Models
{
    public class Pokemon
    {
        [JsonPropertyName("ID")]
        public int ID { get; set; }

        [JsonPropertyName("Pokedex_Number")]
        public int PokedexNumber { get; set; }

        [JsonPropertyName("Name")]
        public string Name { get; set; }

        [JsonPropertyName("Type_1")]
        public string PrimaryType { get; set; }

        [JsonPropertyName("Type_2")]
        public string? SecondaryType { get; set; }

        [JsonPropertyName("HP")]
        public int HP { get; set; }

        [JsonPropertyName("Attack")]
        public int Attack { get; set; }

        [JsonPropertyName("Defense")]
        public int Defense { get; set; }

        [JsonPropertyName("Sp_Atk")]
        public int SpAtk { get; set; }

        [JsonPropertyName("Sp_Def")]
        public int SpDef { get; set; }

        [JsonPropertyName("Speed")]
        public int Speed { get; set; }

        [JsonPropertyName("Generation_Number")]
        public int GenerationNumber { get; set; }

        [JsonPropertyName("Region_Name")]
        public string RegionName { get; set; }

    }
}
