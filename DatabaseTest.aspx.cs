using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace WebApplication1
{
    public partial class DatabaseTest : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowMessage("Click 'Test Database Connection' to check your database setup.", "alert-info");
            }
        }

        protected void btnTestConnection_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;
                results.AppendLine("<div class='alert alert-info'>");
                results.AppendLine("<h6>Connection String:</h6>");
                results.AppendLine($"<small>{connectionString}</small>");
                results.AppendLine("</div>");
                
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    results.AppendLine("<div class='alert alert-success'>");
                    results.AppendLine("<h6><i class='fas fa-check-circle'></i> Connection Successful!</h6>");
                    results.AppendLine($"<p>Server Version: {conn.ServerVersion}</p>");
                    results.AppendLine($"<p>Database: {conn.Database}</p>");
                    results.AppendLine("</div>");
                    
                    conn.Close();
                }
                
                ShowMessage(results.ToString(), "");
            }
            catch (Exception ex)
            {
                results.AppendLine("<div class='alert alert-danger'>");
                results.AppendLine("<h6><i class='fas fa-exclamation-triangle'></i> Connection Failed!</h6>");
                results.AppendLine($"<p><strong>Error:</strong> {ex.Message}</p>");
                results.AppendLine("</div>");
                
                results.AppendLine("<div class='alert alert-warning'>");
                results.AppendLine("<h6>Possible Solutions:</h6>");
                results.AppendLine("<ul>");
                results.AppendLine("<li>Make sure SQL Server Express is running</li>");
                results.AppendLine("<li>Check if the server name 'DESKTOP-FST3V7D\\SQLEXPRESS' is correct</li>");
                results.AppendLine("<li>Verify Windows Authentication is enabled</li>");
                results.AppendLine("<li>Create the 'PortfolioDatabase' if it doesn't exist</li>");
                results.AppendLine("</ul>");
                results.AppendLine("</div>");
                
                ShowMessage(results.ToString(), "");
            }
        }

        protected void btnTestTables_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;
                
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Check if required tables exist
                    string[] requiredTables = { "Skills", "Projects", "Education", "Achievements", "ContactMessages" };
                    
                    results.AppendLine("<div class='alert alert-info'>");
                    results.AppendLine("<h6>Table Check Results:</h6>");
                    results.AppendLine("<ul class='list-unstyled'>");
                    
                    foreach (string tableName in requiredTables)
                    {
                        string checkQuery = $@"
                            SELECT COUNT(*) 
                            FROM INFORMATION_SCHEMA.TABLES 
                            WHERE TABLE_NAME = '{tableName}' AND TABLE_SCHEMA = 'dbo'";
                        
                        using (SqlCommand cmd = new SqlCommand(checkQuery, conn))
                        {
                            int tableExists = Convert.ToInt32(cmd.ExecuteScalar());
                            
                            if (tableExists > 0)
                            {
                                // Check row count
                                string countQuery = $"SELECT COUNT(*) FROM {tableName}";
                                using (SqlCommand countCmd = new SqlCommand(countQuery, conn))
                                {
                                    int rowCount = Convert.ToInt32(countCmd.ExecuteScalar());
                                    results.AppendLine($"<li><i class='fas fa-check text-success'></i> <strong>{tableName}</strong> - {rowCount} records</li>");
                                }
                            }
                            else
                            {
                                results.AppendLine($"<li><i class='fas fa-times text-danger'></i> <strong>{tableName}</strong> - Table missing</li>");
                            }
                        }
                    }
                    
                    results.AppendLine("</ul>");
                    results.AppendLine("</div>");
                    
                    conn.Close();
                }
                
                ShowMessage(results.ToString(), "");
            }
            catch (Exception ex)
            {
                results.AppendLine("<div class='alert alert-danger'>");
                results.AppendLine($"<h6>Error checking tables:</h6>");
                results.AppendLine($"<p>{ex.Message}</p>");
                results.AppendLine("</div>");
                
                ShowMessage(results.ToString(), "");
            }
        }

        protected void btnCreateSampleData_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;
                
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Create tables and sample data
                    string createTablesScript = GetCreateTablesScript();
                    string[] commands = createTablesScript.Split(new string[] { "GO" }, StringSplitOptions.RemoveEmptyEntries);
                    
                    int executedCommands = 0;
                    
                    foreach (string command in commands)
                    {
                        if (!string.IsNullOrWhiteSpace(command))
                        {
                            using (SqlCommand cmd = new SqlCommand(command.Trim(), conn))
                            {
                                cmd.ExecuteNonQuery();
                                executedCommands++;
                            }
                        }
                    }
                    
                    results.AppendLine("<div class='alert alert-success'>");
                    results.AppendLine("<h6><i class='fas fa-check-circle'></i> Sample Data Created!</h6>");
                    results.AppendLine($"<p>Executed {executedCommands} database commands successfully.</p>");
                    results.AppendLine("<p>Your portfolio is now ready with sample data!</p>");
                    results.AppendLine("</div>");
                    
                    conn.Close();
                }
                
                ShowMessage(results.ToString(), "");
            }
            catch (Exception ex)
            {
                results.AppendLine("<div class='alert alert-danger'>");
                results.AppendLine($"<h6>Error creating sample data:</h6>");
                results.AppendLine($"<p>{ex.Message}</p>");
                results.AppendLine("</div>");
                
                ShowMessage(results.ToString(), "");
            }
        }

        private string GetCreateTablesScript()
        {
            return @"
                -- Create Skills table
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Skills' AND xtype='U')
                CREATE TABLE Skills (
                    SkillId int IDENTITY(1,1) PRIMARY KEY,
                    SkillName nvarchar(100) NOT NULL,
                    SkillCategory nvarchar(50) NOT NULL,
                    ProficiencyLevel int NOT NULL CHECK (ProficiencyLevel >= 1 AND ProficiencyLevel <= 100),
                    IconClass nvarchar(50) NULL,
                    Description nvarchar(500) NULL,
                    DisplayOrder int NOT NULL DEFAULT 0,
                    IsActive bit NOT NULL DEFAULT 1,
                    CreatedDate datetime NOT NULL DEFAULT GETDATE(),
                    UpdatedDate datetime NULL
                );
                GO

                -- Create Projects table
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Projects' AND xtype='U')
                CREATE TABLE Projects (
                    ProjectId int IDENTITY(1,1) PRIMARY KEY,
                    Title nvarchar(200) NOT NULL,
                    Description nvarchar(1000) NOT NULL,
                    TechStack nvarchar(500) NULL,
                    GitHubLink nvarchar(500) NULL,
                    DemoLink nvarchar(500) NULL,
                    ImagePath nvarchar(500) NULL,
                    ProjectType nvarchar(50) NOT NULL DEFAULT 'Web',
                    Status nvarchar(50) NOT NULL DEFAULT 'Completed',
                    DisplayOrder int NOT NULL DEFAULT 0,
                    IsFeatured bit NOT NULL DEFAULT 0,
                    IsActive bit NOT NULL DEFAULT 1,
                    CreatedDate datetime NOT NULL DEFAULT GETDATE(),
                    UpdatedDate datetime NULL
                );
                GO

                -- Create Education table
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Education' AND xtype='U')
                CREATE TABLE Education (
                    EducationId int IDENTITY(1,1) PRIMARY KEY,
                    Degree nvarchar(200) NOT NULL,
                    Institution nvarchar(200) NOT NULL,
                    StartYear int NOT NULL,
                    EndYear int NULL,
                    Grade nvarchar(50) NULL,
                    FieldOfStudy nvarchar(200) NULL,
                    Description nvarchar(1000) NULL,
                    Location nvarchar(200) NULL,
                    DisplayOrder int NOT NULL DEFAULT 0,
                    IsActive bit NOT NULL DEFAULT 1,
                    CreatedDate datetime NOT NULL DEFAULT GETDATE(),
                    UpdatedDate datetime NULL
                );
                GO

                -- Create Achievements table
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Achievements' AND xtype='U')
                CREATE TABLE Achievements (
                    AchievementId int IDENTITY(1,1) PRIMARY KEY,
                    Title nvarchar(200) NOT NULL,
                    Description nvarchar(1000) NULL,
                    AchievementDate datetime NOT NULL,
                    Organization nvarchar(200) NULL,
                    Category nvarchar(100) NULL,
                    ImagePath nvarchar(500) NULL,
                    VerificationLink nvarchar(500) NULL,
                    DisplayOrder int NOT NULL DEFAULT 0,
                    IsActive bit NOT NULL DEFAULT 1,
                    CreatedDate datetime NOT NULL DEFAULT GETDATE(),
                    UpdatedDate datetime NULL
                );
                GO

                -- Create ContactMessages table
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ContactMessages' AND xtype='U')
                CREATE TABLE ContactMessages (
                    MessageId int IDENTITY(1,1) PRIMARY KEY,
                    SenderName nvarchar(100) NOT NULL,
                    SenderEmail nvarchar(200) NOT NULL,
                    Subject nvarchar(200) NOT NULL,
                    MessageBody nvarchar(2000) NOT NULL,
                    ReceivedDate datetime NOT NULL DEFAULT GETDATE(),
                    IsRead bit NOT NULL DEFAULT 0,
                    IPAddress nvarchar(50) NULL,
                    UserAgent nvarchar(500) NULL
                );
                GO

                -- Insert sample Skills data
                IF NOT EXISTS (SELECT * FROM Skills)
                BEGIN
                    INSERT INTO Skills (SkillName, SkillCategory, ProficiencyLevel, IconClass, Description, DisplayOrder, IsActive) VALUES
                    ('C#', 'Programming', 90, 'fab fa-microsoft', 'Expert in C# programming language', 1, 1),
                    ('ASP.NET', 'Framework', 85, 'fas fa-globe', 'Experienced in ASP.NET web development', 2, 1),
                    ('JavaScript', 'Programming', 80, 'fab fa-js-square', 'Proficient in JavaScript programming', 3, 1),
                    ('React', 'Framework', 75, 'fab fa-react', 'Skilled in React framework', 4, 1),
                    ('SQL Server', 'Database', 85, 'fas fa-database', 'Expert in SQL Server database management', 5, 1),
                    ('HTML/CSS', 'Technology', 90, 'fab fa-html5', 'Expert in HTML and CSS', 6, 1),
                    ('Bootstrap', 'Framework', 85, 'fab fa-bootstrap', 'Experienced in Bootstrap framework', 7, 1),
                    ('Flutter', 'Mobile', 70, 'fas fa-mobile-alt', 'Learning Flutter for mobile development', 8, 1),
                    ('Python', 'Programming', 75, 'fab fa-python', 'Skilled in Python programming', 9, 1),
                    ('Machine Learning', 'Technology', 65, 'fas fa-brain', 'Developing skills in ML', 10, 1);
                END
                GO

                -- Insert sample Projects data
                IF NOT EXISTS (SELECT * FROM Projects)
                BEGIN
                    INSERT INTO Projects (Title, Description, TechStack, GitHubLink, DemoLink, ProjectType, Status, DisplayOrder, IsFeatured, IsActive) VALUES
                    ('Portfolio Website', 'Dynamic portfolio website with admin panel and database integration', 'ASP.NET, C#, SQL Server, Bootstrap', '#', '#', 'Web', 'Completed', 1, 1, 1),
                    ('E-commerce Platform', 'Full-featured online shopping platform with payment integration', 'ASP.NET Core, Entity Framework, SQL Server', '#', '#', 'Web', 'Completed', 2, 1, 1),
                    ('Mobile Task Manager', 'Cross-platform mobile app for task management and productivity', 'Flutter, Dart, Firebase', '#', '#', 'Mobile', 'In Progress', 3, 1, 1),
                    ('Weather Prediction System', 'Machine learning model for weather prediction using historical data', 'Python, TensorFlow, Pandas', '#', '#', 'ML', 'Completed', 4, 1, 1),
                    ('REST API Service', 'RESTful API service for data management and integration', 'ASP.NET Core, Web API, JWT', '#', '#', 'API', 'Completed', 5, 0, 1),
                    ('Chat Application', 'Real-time chat application with SignalR integration', 'ASP.NET Core, SignalR, JavaScript', '#', '#', 'Web', 'Completed', 6, 0, 1),
                    ('Inventory Management', 'Desktop application for inventory and stock management', 'C#, WinForms, SQL Server', '#', '#', 'Desktop', 'Completed', 7, 0, 1),
                    ('Blog Platform', 'Content management system for blogging and publishing', 'ASP.NET MVC, Entity Framework, Bootstrap', '#', '#', 'Web', 'Completed', 8, 0, 1);
                END
                GO

                -- Insert sample Education data
                IF NOT EXISTS (SELECT * FROM Education)
                BEGIN
                    INSERT INTO Education (Degree, Institution, StartYear, EndYear, Grade, FieldOfStudy, Description, Location, DisplayOrder, IsActive) VALUES
                    ('Bachelor of Science in Computer Science', 'University of Technology', 2020, 2024, 'CGPA: 3.85/4.00', 'Computer Science & Engineering', 'Comprehensive study in computer science fundamentals, software engineering, and emerging technologies', 'Dhaka, Bangladesh', 1, 1),
                    ('Higher Secondary Certificate', 'Dhaka College', 2018, 2020, 'GPA: 5.00/5.00', 'Science', 'Mathematics, Physics, Chemistry, and Information & Communication Technology', 'Dhaka, Bangladesh', 2, 1),
                    ('Secondary School Certificate', 'Dhaka High School', 2016, 2018, 'GPA: 5.00/5.00', 'Science', 'Strong foundation in mathematics and sciences', 'Dhaka, Bangladesh', 3, 1);
                END
                GO

                -- Insert sample Achievements data
                IF NOT EXISTS (SELECT * FROM Achievements)
                BEGIN
                    INSERT INTO Achievements (Title, Description, AchievementDate, Organization, Category, DisplayOrder, IsActive) VALUES
                    ('Best Final Year Project', 'Awarded for outstanding performance in final year capstone project', '2024-05-15', 'University of Technology', 'Academic', 1, 1),
                    ('Microsoft Certified: Azure Fundamentals', 'Achieved Microsoft Azure Fundamentals certification', '2023-08-20', 'Microsoft', 'Certification', 2, 1),
                    ('Programming Contest Winner', 'First place in university programming contest', '2023-03-10', 'University Programming Club', 'Competition', 3, 1),
                    ('Dean\'s List Recognition', 'Recognized for academic excellence with CGPA above 3.75', '2023-12-15', 'University of Technology', 'Academic', 4, 1),
                    ('Open Source Contributor', 'Active contributor to open source projects on GitHub', '2023-06-01', 'GitHub Community', 'Technical', 5, 1);
                END
                GO
            ";
        }

        private void ShowMessage(string message, string cssClass)
        {
            litResults.Text = message;
            if (!string.IsNullOrEmpty(cssClass))
            {
                pnlResults.CssClass = cssClass;
            }
            pnlResults.Visible = true;
        }
    }
}