using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace WebApplication1
{
    public partial class Admin : Page
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Prevent redirect loops by checking query parameters
            string fromAdmin = Request.QueryString["fromAdmin"];
            
            // Check authentication without creating redirect loop
            if (!IsUserAuthenticated())
            {
                System.Diagnostics.Debug.WriteLine("User not authenticated");
                
                // Only redirect if we're not already coming from a redirect
                if (string.IsNullOrEmpty(fromAdmin))
                {
                    Response.Redirect("AdminLogin.aspx?returnUrl=Admin.aspx");
                }
                else
                {
                    // Show simple message instead of redirecting again
                    Response.Write("<h2>Please login first</h2><a href='AdminLogin.aspx'>Go to Login</a>");
                    Response.End();
                }
                return;
            }

            if (!IsPostBack)
            {
                // Load user info
                LoadUserInfo();
                System.Diagnostics.Debug.WriteLine("Admin page loaded successfully for user: " + Session["AdminUsername"]);
            }
        }

        private bool IsUserAuthenticated()
        {
            try 
            {
                bool sessionValid = Session["AdminLoggedIn"] != null && Convert.ToBoolean(Session["AdminLoggedIn"]);
                bool hasUsername = Session["AdminUsername"] != null;
                
                System.Diagnostics.Debug.WriteLine($"Auth Check - Session Valid: {sessionValid}, Has Username: {hasUsername}");
                
                return sessionValid && hasUsername;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Authentication check error: {ex.Message}");
                return false;
            }
        }

        private void LoadUserInfo()
        {
            try
            {
                if (Session["AdminUsername"] != null)
                {
                    string username = Session["AdminUsername"].ToString();
                    string fullName = Session["AdminFullName"]?.ToString() ?? username;
                    
                    // Set username in server control
                    if (litUsername != null)
                    {
                        litUsername.Text = fullName;
                    }
                    
                    System.Diagnostics.Debug.WriteLine($"Admin panel loaded for user: {username}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Warning: No username in session");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in LoadUserInfo: {ex.Message}");
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            // Clear session
            Session.Clear();
            Session.Abandon();

            // Clear authentication cookie
            FormsAuthentication.SignOut();

            // Redirect to login
            Response.Redirect("AdminLogin.aspx");
        }

        #region Dashboard Web Methods

        [WebMethod]
        public static object GetDashboardStats()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT 
                            (SELECT COUNT(*) FROM Skills WHERE IsActive = 1) as TotalSkills,
                            (SELECT COUNT(*) FROM Projects WHERE IsActive = 1) as TotalProjects,
                            (SELECT COUNT(*) FROM Education WHERE IsActive = 1) as TotalEducation,
                            (SELECT COUNT(*) FROM Achievements WHERE IsActive = 1) as TotalAchievements,
                            (SELECT ISNULL(COUNT(*), 0) FROM ContactMessages) as TotalMessages";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                return new
                                {
                                    success = true,
                                    data = new
                                    {
                                        TotalSkills = Convert.ToInt32(reader["TotalSkills"]),
                                        TotalProjects = Convert.ToInt32(reader["TotalProjects"]),
                                        TotalEducation = Convert.ToInt32(reader["TotalEducation"]),
                                        TotalAchievements = Convert.ToInt32(reader["TotalAchievements"]),
                                        TotalMessages = Convert.ToInt32(reader["TotalMessages"])
                                    }
                                };
                            }
                        }
                    }
                }
                
                return new { success = false, message = "No data found" };
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        #endregion

        #region Skills Web Methods

        [WebMethod]
        public static object GetSkills()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = "SELECT SkillId, SkillName, SkillCategory, ProficiencyLevel, IconClass, Description, IsActive FROM Skills ORDER BY DisplayOrder, SkillName";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            
                            var skills = new List<object>();
                            foreach (DataRow row in dt.Rows)
                            {
                                skills.Add(new
                                {
                                    SkillId = Convert.ToInt32(row["SkillId"]),
                                    SkillName = row["SkillName"].ToString(),
                                    SkillCategory = row["SkillCategory"].ToString(),
                                    ProficiencyLevel = Convert.ToInt32(row["ProficiencyLevel"]),
                                    IconClass = row["IconClass"].ToString(),
                                    Description = row["Description"].ToString(),
                                    IsActive = Convert.ToBoolean(row["IsActive"])
                                });
                            }
                            
                            return new { success = true, data = skills };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        [WebMethod]
        public static object AddSkill(string skillName, string skillCategory, int proficiencyLevel, string iconClass, string description)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = @"INSERT INTO Skills (SkillName, SkillCategory, ProficiencyLevel, IconClass, Description, DisplayOrder, IsActive) 
                                   VALUES (@SkillName, @SkillCategory, @ProficiencyLevel, @IconClass, @Description, 
                                          (SELECT ISNULL(MAX(DisplayOrder), 0) + 1 FROM Skills), 1)";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SkillName", skillName ?? "");
                        cmd.Parameters.AddWithValue("@SkillCategory", skillCategory ?? "");
                        cmd.Parameters.AddWithValue("@ProficiencyLevel", proficiencyLevel);
                        cmd.Parameters.AddWithValue("@IconClass", iconClass ?? "fas fa-code");
                        cmd.Parameters.AddWithValue("@Description", description ?? "");
                        
                        int result = cmd.ExecuteNonQuery();
                        return new { success = result > 0, message = result > 0 ? "Skill added successfully" : "Failed to add skill" };
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        [WebMethod]
        public static object UpdateSkill(int skillId, string skillName, string skillCategory, int proficiencyLevel, string iconClass, string description)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = @"UPDATE Skills SET 
                                   SkillName = @SkillName, 
                                   SkillCategory = @SkillCategory, 
                                   ProficiencyLevel = @ProficiencyLevel, 
                                   IconClass = @IconClass, 
                                   Description = @Description
                                   WHERE SkillId = @SkillId";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SkillId", skillId);
                        cmd.Parameters.AddWithValue("@SkillName", skillName ?? "");
                        cmd.Parameters.AddWithValue("@SkillCategory", skillCategory ?? "");
                        cmd.Parameters.AddWithValue("@ProficiencyLevel", proficiencyLevel);
                        cmd.Parameters.AddWithValue("@IconClass", iconClass ?? "fas fa-code");
                        cmd.Parameters.AddWithValue("@Description", description ?? "");
                        
                        int result = cmd.ExecuteNonQuery();
                        return new { success = result > 0, message = result > 0 ? "Skill updated successfully" : "Failed to update skill" };
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        [WebMethod]
        public static object DeleteSkill(int skillId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = "DELETE FROM Skills WHERE SkillId = @SkillId";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SkillId", skillId);
                        
                        int result = cmd.ExecuteNonQuery();
                        return new { success = result > 0, message = result > 0 ? "Skill deleted successfully" : "Failed to delete skill" };
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        [WebMethod]
        public static object GetSkillById(int skillId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = "SELECT SkillId, SkillName, SkillCategory, ProficiencyLevel, IconClass, Description FROM Skills WHERE SkillId = @SkillId";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SkillId", skillId);
                        
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                return new
                                {
                                    success = true,
                                    data = new
                                    {
                                        SkillId = Convert.ToInt32(reader["SkillId"]),
                                        SkillName = reader["SkillName"].ToString(),
                                        SkillCategory = reader["SkillCategory"].ToString(),
                                        ProficiencyLevel = Convert.ToInt32(reader["ProficiencyLevel"]),
                                        IconClass = reader["IconClass"].ToString(),
                                        Description = reader["Description"].ToString()
                                    }
                                };
                            }
                        }
                    }
                }
                
                return new { success = false, message = "Skill not found" };
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        #endregion

        #region Projects Web Methods

        [WebMethod]
        public static object GetProjects()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = "SELECT ProjectId, Title, Description, TechStack, GitHubLink, DemoLink, ProjectType, Status, IsFeatured, CreatedDate FROM Projects WHERE IsActive = 1 ORDER BY DisplayOrder, CreatedDate DESC";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            
                            var projects = new List<object>();
                            foreach (DataRow row in dt.Rows)
                            {
                                projects.Add(new
                                {
                                    ProjectId = Convert.ToInt32(row["ProjectId"]),
                                    Title = row["Title"].ToString(),
                                    Description = row["Description"].ToString(),
                                    TechStack = row["TechStack"].ToString(),
                                    GitHubLink = row["GitHubLink"].ToString(),
                                    DemoLink = row["DemoLink"].ToString(),
                                    ProjectType = row["ProjectType"].ToString(),
                                    Status = row["Status"].ToString(),
                                    IsFeatured = Convert.ToBoolean(row["IsFeatured"]),
                                    CreatedDate = Convert.ToDateTime(row["CreatedDate"]).ToString("yyyy-MM-dd")
                                });
                            }
                            
                            return new { success = true, data = projects };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        [WebMethod]
        public static object AddProject(string title, string description, string techStack, string gitHubLink, string demoLink, string projectType, string status, bool isFeatured)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = @"INSERT INTO Projects (Title, Description, TechStack, GitHubLink, DemoLink, ImagePath, ProjectType, Status, DisplayOrder, IsFeatured, IsActive) 
                                   VALUES (@Title, @Description, @TechStack, @GitHubLink, @DemoLink, '', @ProjectType, @Status, 
                                          (SELECT ISNULL(MAX(DisplayOrder), 0) + 1 FROM Projects), @IsFeatured, 1)";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Title", title ?? "");
                        cmd.Parameters.AddWithValue("@Description", description ?? "");
                        cmd.Parameters.AddWithValue("@TechStack", techStack ?? "");
                        cmd.Parameters.AddWithValue("@GitHubLink", gitHubLink ?? "#");
                        cmd.Parameters.AddWithValue("@DemoLink", demoLink ?? "#");
                        cmd.Parameters.AddWithValue("@ProjectType", projectType ?? "Web");
                        cmd.Parameters.AddWithValue("@Status", status ?? "Completed");
                        cmd.Parameters.AddWithValue("@IsFeatured", isFeatured);
                        
                        int result = cmd.ExecuteNonQuery();
                        return new { success = result > 0, message = result > 0 ? "Project added successfully" : "Failed to add project" };
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        [WebMethod]
        public static object DeleteProject(int projectId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = "DELETE FROM Projects WHERE ProjectId = @ProjectId";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ProjectId", projectId);
                        
                        int result = cmd.ExecuteNonQuery();
                        return new { success = result > 0, message = result > 0 ? "Project deleted successfully" : "Failed to delete project" };
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        #endregion

        #region Education Web Methods

        [WebMethod]
        public static object GetEducation()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = "SELECT EducationId, Degree, Institution, StartYear, EndYear, Grade, FieldOfStudy, Description, Location FROM Education WHERE IsActive = 1 ORDER BY StartYear DESC";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            
                            var education = new List<object>();
                            foreach (DataRow row in dt.Rows)
                            {
                                education.Add(new
                                {
                                    EducationId = Convert.ToInt32(row["EducationId"]),
                                    Degree = row["Degree"].ToString(),
                                    Institution = row["Institution"].ToString(),
                                    StartYear = Convert.ToInt32(row["StartYear"]),
                                    EndYear = row["EndYear"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["EndYear"]),
                                    Grade = row["Grade"].ToString(),
                                    FieldOfStudy = row["FieldOfStudy"].ToString(),
                                    Description = row["Description"].ToString(),
                                    Location = row["Location"].ToString()
                                });
                            }
                            
                            return new { success = true, data = education };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        #endregion

        #region Achievements Web Methods

        [WebMethod]
        public static object GetAchievements()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = "SELECT AchievementId, Title, Description, AchievementDate, Organization, Category FROM Achievements WHERE IsActive = 1 ORDER BY AchievementDate DESC";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            
                            var achievements = new List<object>();
                            foreach (DataRow row in dt.Rows)
                            {
                                achievements.Add(new
                                {
                                    AchievementId = Convert.ToInt32(row["AchievementId"]),
                                    Title = row["Title"].ToString(),
                                    Description = row["Description"].ToString(),
                                    AchievementDate = Convert.ToDateTime(row["AchievementDate"]).ToString("yyyy-MM-dd"),
                                    Organization = row["Organization"].ToString(),
                                    Category = row["Category"].ToString()
                                });
                            }
                            
                            return new { success = true, data = achievements };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        #endregion

        #region Messages Web Methods

        [WebMethod]
        public static object GetMessages()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = "SELECT MessageId, SenderName, SenderEmail, Subject, MessageBody, ReceivedDate, IsRead FROM ContactMessages ORDER BY ReceivedDate DESC";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            
                            var messages = new List<object>();
                            foreach (DataRow row in dt.Rows)
                            {
                                messages.Add(new
                                {
                                    MessageId = Convert.ToInt32(row["MessageId"]),
                                    SenderName = row["SenderName"].ToString(),
                                    SenderEmail = row["SenderEmail"].ToString(),
                                    Subject = row["Subject"].ToString(),
                                    MessageBody = row["MessageBody"].ToString(),
                                    ReceivedDate = Convert.ToDateTime(row["ReceivedDate"]).ToString("yyyy-MM-dd HH:mm"),
                                    IsRead = Convert.ToBoolean(row["IsRead"])
                                });
                            }
                            
                            return new { success = true, data = messages };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        [WebMethod]
        public static object MarkMessageAsRead(int messageId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = "UPDATE ContactMessages SET IsRead = 1 WHERE MessageId = @MessageId";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MessageId", messageId);
                        
                        int result = cmd.ExecuteNonQuery();
                        return new { success = result > 0, message = "Message marked as read" };
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        #endregion

        #region Utility Methods

        [WebMethod]
        public static object CreateSampleData()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Create sample skills if none exist
                    string checkSkillsQuery = "SELECT COUNT(*) FROM Skills";
                    using (SqlCommand cmd = new SqlCommand(checkSkillsQuery, conn))
                    {
                        int skillCount = Convert.ToInt32(cmd.ExecuteScalar());
                        
                        if (skillCount == 0)
                        {
                            string skillsQuery = @"
                                INSERT INTO Skills (SkillName, SkillCategory, ProficiencyLevel, IconClass, Description, DisplayOrder, IsActive) VALUES
                                ('C#', 'Programming', 90, 'fab fa-microsoft', 'Expert in C# programming', 1, 1),
                                ('JavaScript', 'Programming', 85, 'fab fa-js-square', 'Proficient in JavaScript', 2, 1),
                                ('ASP.NET', 'Framework', 88, 'fas fa-globe', 'Expert in ASP.NET development', 3, 1),
                                ('React', 'Framework', 75, 'fab fa-react', 'Skilled in React framework', 4, 1),
                                ('SQL Server', 'Database', 85, 'fas fa-database', 'Expert in SQL Server', 5, 1)";
                            
                            using (SqlCommand skillCmd = new SqlCommand(skillsQuery, conn))
                            {
                                skillCmd.ExecuteNonQuery();
                            }
                        }
                    }
                    
                    // Create sample projects if none exist
                    string checkProjectsQuery = "SELECT COUNT(*) FROM Projects";
                    using (SqlCommand cmd = new SqlCommand(checkProjectsQuery, conn))
                    {
                        int projectCount = Convert.ToInt32(cmd.ExecuteScalar());
                        
                        if (projectCount == 0)
                        {
                            string projectsQuery = @"
                                INSERT INTO Projects (Title, Description, TechStack, GitHubLink, DemoLink, ProjectType, Status, DisplayOrder, IsFeatured, IsActive) VALUES
                                ('Portfolio Website', 'Dynamic portfolio with admin panel', 'ASP.NET, C#, Bootstrap', '#', '#', 'Web', 'Completed', 1, 1, 1),
                                ('Task Management App', 'Full-featured task management system', 'React, Node.js, MongoDB', '#', '#', 'Web', 'Completed', 2, 1, 1),
                                ('Mobile Shopping App', 'Cross-platform mobile shopping application', 'Flutter, Firebase', '#', '#', 'Mobile', 'In Progress', 3, 1, 1)";
                            
                            using (SqlCommand projectCmd = new SqlCommand(projectsQuery, conn))
                            {
                                projectCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
                
                return new { success = true, message = "Sample data created successfully" };
            }
            catch (Exception ex)
            {
                return new { success = false, message = "Error creating sample data: " + ex.Message };
            }
        }

        #endregion
    }
}