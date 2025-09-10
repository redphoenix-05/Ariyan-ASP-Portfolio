using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;

namespace WebApplication1
{
    public partial class WorkingAdmin : Page
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Page loads normally, JavaScript handles the operations
        }

        [WebMethod]
        public static object TestConnection()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    return new { 
                        success = true, 
                        message = $"Connected successfully to {conn.Database} on {conn.DataSource}"
                    };
                }
            }
            catch (Exception ex)
            {
                return new { 
                    success = false, 
                    message = $"Connection failed: {ex.Message}"
                };
            }
        }

        [WebMethod]
        public static object CreateSampleData()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Create Skills sample data
                    string skillsQuery = @"
                        IF NOT EXISTS (SELECT * FROM Skills WHERE SkillName = 'C#')
                        INSERT INTO Skills (SkillName, SkillCategory, ProficiencyLevel, IconClass, Description, DisplayOrder, IsActive) 
                        VALUES ('C#', 'Programming', 90, 'fab fa-microsoft', 'Expert in C# programming', 1, 1);
                        
                        IF NOT EXISTS (SELECT * FROM Skills WHERE SkillName = 'JavaScript')
                        INSERT INTO Skills (SkillName, SkillCategory, ProficiencyLevel, IconClass, Description, DisplayOrder, IsActive) 
                        VALUES ('JavaScript', 'Programming', 85, 'fab fa-js-square', 'Proficient in JavaScript', 2, 1);
                        
                        IF NOT EXISTS (SELECT * FROM Skills WHERE SkillName = 'React')
                        INSERT INTO Skills (SkillName, SkillCategory, ProficiencyLevel, IconClass, Description, DisplayOrder, IsActive) 
                        VALUES ('React', 'Framework', 80, 'fab fa-react', 'Experienced with React', 3, 1);";

                    using (SqlCommand cmd = new SqlCommand(skillsQuery, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }

                    // Create Projects sample data
                    string projectsQuery = @"
                        IF NOT EXISTS (SELECT * FROM Projects WHERE Title = 'Portfolio Website')
                        INSERT INTO Projects (Title, Description, TechStack, GitHubLink, DemoLink, ProjectType, Status, DisplayOrder, IsFeatured, IsActive) 
                        VALUES ('Portfolio Website', 'Dynamic portfolio with admin panel', 'ASP.NET, C#, Bootstrap', '#', '#', 'Web', 'Completed', 1, 1, 1);
                        
                        IF NOT EXISTS (SELECT * FROM Projects WHERE Title = 'Mobile Task App')
                        INSERT INTO Projects (Title, Description, TechStack, GitHubLink, DemoLink, ProjectType, Status, DisplayOrder, IsFeatured, IsActive) 
                        VALUES ('Mobile Task App', 'Cross-platform task management app', 'Flutter, Dart', '#', '#', 'Mobile', 'In Progress', 2, 1, 1);";

                    using (SqlCommand cmd = new SqlCommand(projectsQuery, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }
                }

                return new { 
                    success = true, 
                    message = "Sample data created successfully!"
                };
            }
            catch (Exception ex)
            {
                return new { 
                    success = false, 
                    message = $"Error creating sample data: {ex.Message}"
                };
            }
        }

        [WebMethod]
        public static object GetSkills()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT SkillName, SkillCategory, ProficiencyLevel FROM Skills WHERE IsActive = 1 ORDER BY DisplayOrder, SkillName";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            
                            var skills = new System.Collections.Generic.List<object>();
                            foreach (DataRow row in dt.Rows)
                            {
                                skills.Add(new {
                                    SkillName = row["SkillName"].ToString(),
                                    SkillCategory = row["SkillCategory"].ToString(),
                                    ProficiencyLevel = Convert.ToInt32(row["ProficiencyLevel"])
                                });
                            }
                            
                            return new { 
                                success = true, 
                                data = skills
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new { 
                    success = false, 
                    message = $"Error loading skills: {ex.Message}"
                };
            }
        }

        [WebMethod]
        public static object GetProjects()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT Title, ProjectType, Status, IsFeatured FROM Projects WHERE IsActive = 1 ORDER BY DisplayOrder, Title";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            
                            var projects = new System.Collections.Generic.List<object>();
                            foreach (DataRow row in dt.Rows)
                            {
                                projects.Add(new {
                                    Title = row["Title"].ToString(),
                                    ProjectType = row["ProjectType"].ToString(),
                                    Status = row["Status"].ToString(),
                                    IsFeatured = Convert.ToBoolean(row["IsFeatured"])
                                });
                            }
                            
                            return new { 
                                success = true, 
                                data = projects
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new { 
                    success = false, 
                    message = $"Error loading projects: {ex.Message}"
                };
            }
        }
    }
}