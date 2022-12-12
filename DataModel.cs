using System.Text.Json.Serialization;

namespace PokemonAPI
{
    public class DataModel
    {
        [JsonPropertyName("X")]
        public string X { get; set; }

        [JsonPropertyName("Y")]
        public int Y { get; set; }

        //public int _X => SetInt(X);
        //public int _Y => SetInt(Y);

        //static int SetInt(string str)
        //{
        //    if (int.TryParse(str, out int temp))
        //    {
        //        return temp;
        //    }
        //    else
        //    {
        //        return 0;
        //    }
        //}
    }
}
