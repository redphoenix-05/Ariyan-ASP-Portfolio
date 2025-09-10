using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace WebApplication1
{
    public static class DatabaseHelper
    {
        private static readonly string connectionString = GetConnectionString();

        private static string GetConnectionString()
        {
            try
            {
                return ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;
            }
            catch
            {
                // Fallback connection string if config fails
                return @"Data Source=DESKTOP-FST3V7D\SQLEXPRESS;Initial Catalog=PortfolioDatabase;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=True";
            }
        }

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }

        public static string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password + "PortfolioSalt2024"));
                return Convert.ToBase64String(hashedBytes);
            }
        }

        public static bool VerifyPassword(string password, string hashedPassword)
        {
            string hashOfInput = HashPassword(password);
            return string.Equals(hashOfInput, hashedPassword, StringComparison.OrdinalIgnoreCase);
        }

        public static DataTable ExecuteQuery(string query, params SqlParameter[] parameters)
        {
            DataTable dataTable = new DataTable();
            try
            {
                using (SqlConnection connection = GetConnection())
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        if (parameters != null)
                        {
                            command.Parameters.AddRange(parameters);
                        }
                        
                        connection.Open();
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            adapter.Fill(dataTable);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Database query error: {ex.Message}", ex);
            }
            return dataTable;
        }

        public static int ExecuteNonQuery(string query, params SqlParameter[] parameters)
        {
            try
            {
                using (SqlConnection connection = GetConnection())
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        if (parameters != null)
                        {
                            command.Parameters.AddRange(parameters);
                        }
                        
                        connection.Open();
                        return command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Database execution error: {ex.Message}", ex);
            }
        }

        public static object ExecuteScalar(string query, params SqlParameter[] parameters)
        {
            try
            {
                using (SqlConnection connection = GetConnection())
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        if (parameters != null)
                        {
                            command.Parameters.AddRange(parameters);
                        }
                        
                        connection.Open();
                        return command.ExecuteScalar();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Database scalar execution error: {ex.Message}", ex);
            }
        }

        #region Public Display Methods

        // Get all active skills ordered by display order
        public static DataTable GetSkills()
        {
            string query = "SELECT SkillName, SkillCategory, ProficiencyLevel, IconClass, Description FROM Skills WHERE IsActive = 1 ORDER BY DisplayOrder, SkillName";
            return ExecuteQuery(query);
        }

        // Get featured projects for home page
        public static DataTable GetFeaturedProjects()
        {
            string query = "SELECT TOP 3 Title, Description, TechStack, GitHubLink, DemoLink, ProjectType, Status FROM Projects WHERE IsActive = 1 AND IsFeatured = 1 ORDER BY DisplayOrder";
            return ExecuteQuery(query);
        }

        // Get all projects
        public static DataTable GetAllProjects()
        {
            string query = "SELECT Title, Description, TechStack, GitHubLink, DemoLink, ProjectType, Status FROM Projects WHERE IsActive = 1 ORDER BY DisplayOrder, CreatedDate DESC";
            return ExecuteQuery(query);
        }

        // Get all achievements
        public static DataTable GetAchievements()
        {
            string query = "SELECT Title, Description, AchievementDate, Organization, Category FROM Achievements WHERE IsActive = 1 ORDER BY DisplayOrder, AchievementDate DESC";
            return ExecuteQuery(query);
        }

        // Get all education records
        public static DataTable GetEducation()
        {
            string query = "SELECT Degree, Institution, StartYear, EndYear, Grade, FieldOfStudy, Location FROM Education WHERE IsActive = 1 ORDER BY DisplayOrder, StartYear DESC";
            return ExecuteQuery(query);
        }

        // Get project statistics
        public static DataTable GetProjectStats()
        {
            string query = @"
                SELECT 
                    (SELECT COUNT(*) FROM Projects WHERE IsActive = 1) as TotalProjects,
                    (SELECT COUNT(*) FROM Projects WHERE IsActive = 1 AND ProjectType = 'Mobile') as MobileApps,
                    (SELECT COUNT(*) FROM Projects WHERE IsActive = 1 AND ProjectType = 'Web') as WebApps,
                    (SELECT COUNT(*) FROM Projects WHERE IsActive = 1 AND GitHubLink IS NOT NULL AND GitHubLink != '#') as OpenSource,
                    (SELECT COUNT(*) FROM Skills WHERE IsActive = 1) as Technologies,
                    (SELECT COUNT(*) FROM Achievements WHERE IsActive = 1) as Achievements";
            return ExecuteQuery(query);
        }

        #endregion

        #region Admin CRUD Operations

        // ========== SKILLS MANAGEMENT ==========
        public static DataTable GetAllSkillsForAdmin()
        {
            string query = "SELECT * FROM Skills ORDER BY DisplayOrder, SkillName";
            return ExecuteQuery(query);
        }

        public static DataTable GetSkillById(int skillId)
        {
            string query = "SELECT * FROM Skills WHERE SkillId = @SkillId";
            return ExecuteQuery(query, new SqlParameter("@SkillId", skillId));
        }

        public static int InsertSkill(string skillName, string skillCategory, int proficiencyLevel, string iconClass, string description, int displayOrder, bool isActive)
        {
            string query = @"INSERT INTO Skills (SkillName, SkillCategory, ProficiencyLevel, IconClass, Description, DisplayOrder, IsActive) 
                            VALUES (@SkillName, @SkillCategory, @ProficiencyLevel, @IconClass, @Description, @DisplayOrder, @IsActive);
                            SELECT SCOPE_IDENTITY();";
            
            return Convert.ToInt32(ExecuteScalar(query,
                new SqlParameter("@SkillName", skillName),
                new SqlParameter("@SkillCategory", skillCategory),
                new SqlParameter("@ProficiencyLevel", proficiencyLevel),
                new SqlParameter("@IconClass", iconClass ?? (object)DBNull.Value),
                new SqlParameter("@Description", description ?? (object)DBNull.Value),
                new SqlParameter("@DisplayOrder", displayOrder),
                new SqlParameter("@IsActive", isActive)));
        }

        public static int UpdateSkill(int skillId, string skillName, string skillCategory, int proficiencyLevel, string iconClass, string description, int displayOrder, bool isActive)
        {
            string query = @"UPDATE Skills SET 
                            SkillName = @SkillName, 
                            SkillCategory = @SkillCategory, 
                            ProficiencyLevel = @ProficiencyLevel, 
                            IconClass = @IconClass, 
                            Description = @Description, 
                            DisplayOrder = @DisplayOrder, 
                            IsActive = @IsActive 
                            WHERE SkillId = @SkillId";
            
            return ExecuteNonQuery(query,
                new SqlParameter("@SkillId", skillId),
                new SqlParameter("@SkillName", skillName),
                new SqlParameter("@SkillCategory", skillCategory),
                new SqlParameter("@ProficiencyLevel", proficiencyLevel),
                new SqlParameter("@IconClass", iconClass ?? (object)DBNull.Value),
                new SqlParameter("@Description", description ?? (object)DBNull.Value),
                new SqlParameter("@DisplayOrder", displayOrder),
                new SqlParameter("@IsActive", isActive));
        }

        public static int DeleteSkill(int skillId)
        {
            string query = "DELETE FROM Skills WHERE SkillId = @SkillId";
            return ExecuteNonQuery(query, new SqlParameter("@SkillId", skillId));
        }

        // ========== PROJECTS MANAGEMENT ==========
        public static DataTable GetAllProjectsForAdmin()
        {
            string query = "SELECT * FROM Projects ORDER BY DisplayOrder, CreatedDate DESC";
            return ExecuteQuery(query);
        }

        public static DataTable GetProjectById(int projectId)
        {
            string query = "SELECT * FROM Projects WHERE ProjectId = @ProjectId";
            return ExecuteQuery(query, new SqlParameter("@ProjectId", projectId));
        }

        public static int InsertProject(string title, string description, string techStack, string gitHubLink, string demoLink, string imagePath, string projectType, string status, int displayOrder, bool isFeatured, bool isActive)
        {
            string query = @"INSERT INTO Projects (Title, Description, TechStack, GitHubLink, DemoLink, ImagePath, ProjectType, Status, DisplayOrder, IsFeatured, IsActive) 
                            VALUES (@Title, @Description, @TechStack, @GitHubLink, @DemoLink, @ImagePath, @ProjectType, @Status, @DisplayOrder, @IsFeatured, @IsActive);
                            SELECT SCOPE_IDENTITY();";
            
            return Convert.ToInt32(ExecuteScalar(query,
                new SqlParameter("@Title", title),
                new SqlParameter("@Description", description),
                new SqlParameter("@TechStack", techStack),
                new SqlParameter("@GitHubLink", gitHubLink ?? (object)DBNull.Value),
                new SqlParameter("@DemoLink", demoLink ?? (object)DBNull.Value),
                new SqlParameter("@ImagePath", imagePath ?? (object)DBNull.Value),
                new SqlParameter("@ProjectType", projectType),
                new SqlParameter("@Status", status),
                new SqlParameter("@DisplayOrder", displayOrder),
                new SqlParameter("@IsFeatured", isFeatured),
                new SqlParameter("@IsActive", isActive)));
        }

        public static int UpdateProject(int projectId, string title, string description, string techStack, string gitHubLink, string demoLink, string imagePath, string projectType, string status, int displayOrder, bool isFeatured, bool isActive)
        {
            string query = @"UPDATE Projects SET 
                            Title = @Title, 
                            Description = @Description, 
                            TechStack = @TechStack, 
                            GitHubLink = @GitHubLink, 
                            DemoLink = @DemoLink, 
                            ImagePath = @ImagePath, 
                            ProjectType = @ProjectType, 
                            Status = @Status, 
                            DisplayOrder = @DisplayOrder, 
                            IsFeatured = @IsFeatured, 
                            IsActive = @IsActive 
                            WHERE ProjectId = @ProjectId";
            
            return ExecuteNonQuery(query,
                new SqlParameter("@ProjectId", projectId),
                new SqlParameter("@Title", title),
                new SqlParameter("@Description", description),
                new SqlParameter("@TechStack", techStack),
                new SqlParameter("@GitHubLink", gitHubLink ?? (object)DBNull.Value),
                new SqlParameter("@DemoLink", demoLink ?? (object)DBNull.Value),
                new SqlParameter("@ImagePath", imagePath ?? (object)DBNull.Value),
                new SqlParameter("@ProjectType", projectType),
                new SqlParameter("@Status", status),
                new SqlParameter("@DisplayOrder", displayOrder),
                new SqlParameter("@IsFeatured", isFeatured),
                new SqlParameter("@IsActive", isActive));
        }

        public static int DeleteProject(int projectId)
        {
            string query = "DELETE FROM Projects WHERE ProjectId = @ProjectId";
            return ExecuteNonQuery(query, new SqlParameter("@ProjectId", projectId));
        }

        // ========== ACHIEVEMENTS MANAGEMENT ==========
        public static DataTable GetAllAchievementsForAdmin()
        {
            string query = "SELECT * FROM Achievements ORDER BY DisplayOrder, AchievementDate DESC";
            return ExecuteQuery(query);
        }

        public static DataTable GetAchievementById(int achievementId)
        {
            string query = "SELECT * FROM Achievements WHERE AchievementId = @AchievementId";
            return ExecuteQuery(query, new SqlParameter("@AchievementId", achievementId));
        }

        public static int InsertAchievement(string title, string description, DateTime achievementDate, string organization, string category, string imagePath, string verificationLink, int displayOrder, bool isActive)
        {
            string query = @"INSERT INTO Achievements (Title, Description, AchievementDate, Organization, Category, ImagePath, VerificationLink, DisplayOrder, IsActive) 
                            VALUES (@Title, @Description, @AchievementDate, @Organization, @Category, @ImagePath, @VerificationLink, @DisplayOrder, @IsActive);
                            SELECT SCOPE_IDENTITY();";
            
            return Convert.ToInt32(ExecuteScalar(query,
                new SqlParameter("@Title", title),
                new SqlParameter("@Description", description),
                new SqlParameter("@AchievementDate", achievementDate),
                new SqlParameter("@Organization", organization ?? (object)DBNull.Value),
                new SqlParameter("@Category", category ?? (object)DBNull.Value),
                new SqlParameter("@ImagePath", imagePath ?? (object)DBNull.Value),
                new SqlParameter("@VerificationLink", verificationLink ?? (object)DBNull.Value),
                new SqlParameter("@DisplayOrder", displayOrder),
                new SqlParameter("@IsActive", isActive)));
        }

        public static int UpdateAchievement(int achievementId, string title, string description, DateTime achievementDate, string organization, string category, string imagePath, string verificationLink, int displayOrder, bool isActive)
        {
            string query = @"UPDATE Achievements SET 
                            Title = @Title, 
                            Description = @Description, 
                            AchievementDate = @AchievementDate, 
                            Organization = @Organization, 
                            Category = @Category, 
                            ImagePath = @ImagePath, 
                            VerificationLink = @VerificationLink, 
                            DisplayOrder = @DisplayOrder, 
                            IsActive = @IsActive 
                            WHERE AchievementId = @AchievementId";
            
            return ExecuteNonQuery(query,
                new SqlParameter("@AchievementId", achievementId),
                new SqlParameter("@Title", title),
                new SqlParameter("@Description", description),
                new SqlParameter("@AchievementDate", achievementDate),
                new SqlParameter("@Organization", organization ?? (object)DBNull.Value),
                new SqlParameter("@Category", category ?? (object)DBNull.Value),
                new SqlParameter("@ImagePath", imagePath ?? (object)DBNull.Value),
                new SqlParameter("@VerificationLink", verificationLink ?? (object)DBNull.Value),
                new SqlParameter("@DisplayOrder", displayOrder),
                new SqlParameter("@IsActive", isActive));
        }

        public static int DeleteAchievement(int achievementId)
        {
            string query = "DELETE FROM Achievements WHERE AchievementId = @AchievementId";
            return ExecuteNonQuery(query, new SqlParameter("@AchievementId", achievementId));
        }

        // ========== EDUCATION MANAGEMENT ==========
        public static DataTable GetAllEducationForAdmin()
        {
            string query = "SELECT * FROM Education ORDER BY DisplayOrder, StartYear DESC";
            return ExecuteQuery(query);
        }

        public static DataTable GetEducationById(int educationId)
        {
            string query = "SELECT * FROM Education WHERE EducationId = @EducationId";
            return ExecuteQuery(query, new SqlParameter("@EducationId", educationId));
        }

        public static int InsertEducation(string degree, string institution, int startYear, int? endYear, string grade, string fieldOfStudy, string description, string location, int displayOrder, bool isActive)
        {
            string query = @"INSERT INTO Education (Degree, Institution, StartYear, EndYear, Grade, FieldOfStudy, Description, Location, DisplayOrder, IsActive) 
                            VALUES (@Degree, @Institution, @StartYear, @EndYear, @Grade, @FieldOfStudy, @Description, @Location, @DisplayOrder, @IsActive);
                            SELECT SCOPE_IDENTITY();";
            
            return Convert.ToInt32(ExecuteScalar(query,
                new SqlParameter("@Degree", degree),
                new SqlParameter("@Institution", institution),
                new SqlParameter("@StartYear", startYear),
                new SqlParameter("@EndYear", endYear.HasValue ? (object)endYear.Value : DBNull.Value),
                new SqlParameter("@Grade", grade ?? (object)DBNull.Value),
                new SqlParameter("@FieldOfStudy", fieldOfStudy ?? (object)DBNull.Value),
                new SqlParameter("@Description", description ?? (object)DBNull.Value),
                new SqlParameter("@Location", location ?? (object)DBNull.Value),
                new SqlParameter("@DisplayOrder", displayOrder),
                new SqlParameter("@IsActive", isActive)));
        }

        public static int UpdateEducation(int educationId, string degree, string institution, int startYear, int? endYear, string grade, string fieldOfStudy, string description, string location, int displayOrder, bool isActive)
        {
            string query = @"UPDATE Education SET 
                            Degree = @Degree, 
                            Institution = @Institution, 
                            StartYear = @StartYear, 
                            EndYear = @EndYear, 
                            Grade = @Grade, 
                            FieldOfStudy = @FieldOfStudy, 
                            Description = @Description, 
                            Location = @Location, 
                            DisplayOrder = @DisplayOrder, 
                            IsActive = @IsActive 
                            WHERE EducationId = @EducationId";
            
            return ExecuteNonQuery(query,
                new SqlParameter("@EducationId", educationId),
                new SqlParameter("@Degree", degree),
                new SqlParameter("@Institution", institution),
                new SqlParameter("@StartYear", startYear),
                new SqlParameter("@EndYear", endYear.HasValue ? (object)endYear.Value : DBNull.Value),
                new SqlParameter("@Grade", grade ?? (object)DBNull.Value),
                new SqlParameter("@FieldOfStudy", fieldOfStudy ?? (object)DBNull.Value),
                new SqlParameter("@Description", description ?? (object)DBNull.Value),
                new SqlParameter("@Location", location ?? (object)DBNull.Value),
                new SqlParameter("@DisplayOrder", displayOrder),
                new SqlParameter("@IsActive", isActive));
        }

        public static int DeleteEducation(int educationId)
        {
            string query = "DELETE FROM Education WHERE EducationId = @EducationId";
            return ExecuteNonQuery(query, new SqlParameter("@EducationId", educationId));
        }

        // ========== CONTACT MESSAGES ==========
        public static DataTable GetAllContactMessages()
        {
            string query = "SELECT * FROM ContactMessages ORDER BY ReceivedDate DESC";
            return ExecuteQuery(query);
        }

        public static int MarkMessageAsRead(int messageId)
        {
            string query = "UPDATE ContactMessages SET IsRead = 1 WHERE MessageId = @MessageId";
            return ExecuteNonQuery(query, new SqlParameter("@MessageId", messageId));
        }

        public static int DeleteContactMessage(int messageId)
        {
            string query = "DELETE FROM ContactMessages WHERE MessageId = @MessageId";
            return ExecuteNonQuery(query, new SqlParameter("@MessageId", messageId));
        }

        // ========== ADMIN AUTHENTICATION ==========
        public static bool ValidateAdmin(string username, string password)
        {
            string query = "SELECT PasswordHash FROM AdminUsers WHERE Username = @Username";
            object result = ExecuteScalar(query, new SqlParameter("@Username", username));
            
            if (result != null)
            {
                string storedHash = result.ToString();
                return VerifyPassword(password, storedHash);
            }
            return false;
        }

        public static int UpdateLastLogin(string username)
        {
            string query = "UPDATE AdminUsers SET LastLoginDate = GETDATE() WHERE Username = @Username";
            return ExecuteNonQuery(query, new SqlParameter("@Username", username));
        }

        // ========== DASHBOARD STATISTICS ==========
        public static DataTable GetDashboardStats()
        {
            string query = @"
                SELECT 
                    (SELECT COUNT(*) FROM Skills WHERE IsActive = 1) as TotalSkills,
                    (SELECT COUNT(*) FROM Projects WHERE IsActive = 1) as TotalProjects,
                    (SELECT COUNT(*) FROM Projects WHERE IsActive = 1 AND IsFeatured = 1) as FeaturedProjects,
                    (SELECT COUNT(*) FROM Achievements WHERE IsActive = 1) as TotalAchievements,
                    (SELECT COUNT(*) FROM Education WHERE IsActive = 1) as TotalEducation,
                    (SELECT COUNT(*) FROM ContactMessages WHERE IsRead = 0) as UnreadMessages,
                    (SELECT COUNT(*) FROM ContactMessages) as TotalMessages";
            return ExecuteQuery(query);
        }

        #endregion
    }
}