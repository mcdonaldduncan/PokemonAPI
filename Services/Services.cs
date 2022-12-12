using Microsoft.Data.SqlClient;
using System;
using System.Data;

namespace PokemonAPI.Services
{
    public class Services
    {
        List<Error> Errors = new List<Error>();

        private string SQLConnString { get; set; } = string.Empty;

        public void PrepareSQLConnectionString()
        {
            if (SQLConnString == string.Empty)
            {
                SqlConnectionStringBuilder sqlConStringBuilder = new SqlConnectionStringBuilder();
                sqlConStringBuilder["server"] = @"(localdb)\MSSQLLocalDB";
                sqlConStringBuilder["Trusted_Connection"] = true;
                sqlConStringBuilder["Integrated Security"] = "SSPI";
                sqlConStringBuilder["Initial Catalog"] = "PROG260FA22";

                SQLConnString = sqlConStringBuilder.ToString();
            }
        }

        public List<Pokemon> GetPokemon(string type, int genNum)
        {
            List<Pokemon> pokemon = new List<Pokemon>();

            try
            {
                using (SqlConnection conn = new SqlConnection(SQLConnString))
                {
                    conn.Open();

                    string sproc = $@"[dbo].[sp_FilteredPokemon]";

                    using (var command = new SqlCommand(sproc, conn))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@Type", type == "null" ? DBNull.Value : type);
                        command.Parameters.AddWithValue("@GenNum", genNum == 0 ? DBNull.Value : genNum);

                        var reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            Pokemon temp = new Pokemon();
                            int i = 0;

                            temp.ID = (int)reader[i++];
                            temp.PokedexNumber = (int)reader[i++];
                            temp.Name = (string)reader[i++];
                            temp.PrimaryType = (string)reader[i++];
                            temp.SecondaryType = reader[i++]?.ToString();
                            temp.HP = (int)reader[i++];
                            temp.Attack = (int)reader[i++];
                            temp.Defense = (int)reader[i++];
                            temp.SpAtk = (int)reader[i++];
                            temp.SpDef = (int)reader[i++];
                            temp.Speed = (int)reader[i++];
                            temp.GenerationNumber = (int)reader[i++];
                            temp.RegionName = (string)reader[i++];

                            pokemon.Add(temp);
                        }

                        reader.Close();

                    }

                    conn.Close();
                }

            }
            catch (IOException ioe)
            {
                Errors.Add(new Error(ioe.Message, ioe.Source));
            }
            catch (Exception e)
            {
                Errors.Add(new Error(e.Message, e.Source));
            }

            return pokemon;
        }

        public List<Type> GetTypes()
        {
            List<Type> types = new List<Type>();

            try
            {
                using (SqlConnection conn = new SqlConnection(SQLConnString))
                {
                    conn.Open();

                    string sproc = $@"[dbo].[sp_GetAllTypes]";

                    using (var command = new SqlCommand(sproc, conn))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        var reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            Type temp = new Type();
                            temp.Name = (string)reader["Name"];
                            temp.HexColor = (string)reader["HexColor"];
                            types.Add(temp);
                        }

                        reader.Close();
                    }
                    conn.Close();
                }

            }
            catch (IOException ioe)
            {
                Errors.Add(new Error(ioe.Message, ioe.Source));
            }
            catch (Exception e)
            {
                Errors.Add(new Error(e.Message, e.Source));
            }

            return types;
        }

        public List<Generation> GetRegions()
        {
            List<Generation> regions = new List<Generation>();

            try
            {
                using (SqlConnection conn = new SqlConnection(SQLConnString))
                {
                    conn.Open();

                    string sproc = $@"[dbo].[sp_GetAllRegions]";

                    using (var command = new SqlCommand(sproc, conn))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        var reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            Generation temp = new Generation();
                            temp.Generation_Number = (int)reader["Generation_Number"];
                            temp.Region_Name = (string)reader["Name"];
                            regions.Add(temp);
                        }

                        reader.Close();
                    }
                    conn.Close();
                }

            }
            catch (IOException ioe)
            {
                Errors.Add(new Error(ioe.Message, ioe.Source));
            }
            catch (Exception e)
            {
                Errors.Add(new Error(e.Message, e.Source));
            }

            return regions;
        }

        public List<DataModel> GetChart(string sproc)
        {
            List<DataModel> data = new List<DataModel>();

            try
            {
                using (SqlConnection conn = new SqlConnection(SQLConnString))
                {
                    conn.Open();



                    using (var command = new SqlCommand(sproc, conn))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        var reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            DataModel temp = new DataModel();
                            temp.X = (string)reader["x"];
                            temp.Y = (int)reader["y"];
                            data.Add(temp);
                        }

                        reader.Close();
                    }
                    conn.Close();
                }

            }
            catch (IOException ioe)
            {
                Errors.Add(new Error(ioe.Message, ioe.Source));
            }
            catch (Exception e)
            {
                Errors.Add(new Error(e.Message, e.Source));
            }

            return data;
        }


    }

}
