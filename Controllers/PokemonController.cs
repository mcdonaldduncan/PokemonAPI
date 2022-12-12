using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace PokemonAPI.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PokemonController : ControllerBase
    {
        Services services = new Services();
        
        // GET: api/<PokemonController>
        [HttpGet("get-filtered/{type}/{genNum}")]
        public IEnumerable<Pokemon> Get([FromRoute] string type, int genNum)
        {
            services.PrepareSQLConnectionString();
            return services.GetPokemon(type, genNum);
        }

        // GET api/<PokemonController>/5
        [HttpGet("get-types")]
        public IEnumerable<Type> GetTypes()
        {
            services.PrepareSQLConnectionString();
            return services.GetTypes();
        }

        // GET api/<PokemonController>/5
        [HttpGet("get-regions")]
        public IEnumerable<Generation> GetRegions()
        {
            services.PrepareSQLConnectionString();
            return services.GetRegions();
        }

        [HttpGet("get-type-chart")]
        public IEnumerable<DataModel> GetTypeChart()
        {
            services.PrepareSQLConnectionString();
            return services.GetChart($@"[dbo].[sp_GetTypeChartData]");
        }

        [HttpGet("get-generation-chart")]
        public IEnumerable<DataModel> GetGenerationChart()
        {
            services.PrepareSQLConnectionString();
            return services.GetChart($@"[dbo].[sp_GetGenerationChartData]");
        }

    }
}
