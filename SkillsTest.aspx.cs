using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace WebApplication1
{
    public partial class SkillsTest : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSkillsFromDatabase();
            }
        }

        private void LoadSkillsFromDatabase()
        {
            try
            {
                // First check connection
                TestConnection();
                
                DataTable skills = GetSkills();
                
                // If no skills found, create some sample data
                if (skills.Rows.Count == 0)
                {
                    CreateSampleSkills();
                    skills = GetSkills(); // Reload after creating sample data
                }
                
                if (skills.Rows.Count > 0)
                {
                    StringBuilder skillsHtml = new StringBuilder();
                    
                    foreach (DataRow row in skills.Rows)
                    {
                        string skillName = row["SkillName"].ToString();
                        string category = row["SkillCategory"].ToString();
                        int proficiency = Convert.ToInt32(row["ProficiencyLevel"]);
                        string iconClass = row["IconClass"].ToString();
                        string description = row["Description"].ToString();
                        
                        // Generate card color based on category
                        string cardColor = GetCategoryColor(category);
                        string badgeColor = GetBadgeColor(category);
                        
                        skillsHtml.AppendFormat(@"
                            <div class='col-lg-4 col-md-6 mb-4'>
                                <div class='card skill-card h-100'>
                                    <div class='card-body text-center'>
                                        <div class='skill-icon {0} mb-3'>
                                            <i class='{1} fa-3x'></i>
                                        </div>
                                        <h5 class='card-title'>{2}</h5>
                                        <span class='badge {3} mb-3'>{4}</span>
                                        <div class='progress mb-3'>
                                            <div class='progress-bar progress-bar-striped' 
                                                 role='progressbar' 
                                                 style='width: {5}%' 
                                                 aria-valuenow='{5}' 
                                                 aria-valuemin='0' 
                                                 aria-valuemax='100'>
                                                {5}%
                                            </div>
                                        </div>
                                        <p class='card-text text-muted'>{6}</p>
                                    </div>
                                </div>
                            </div>",
                            cardColor, iconClass, skillName, badgeColor, category, proficiency, description);
                    }
                    
                    // Inject skills into the page
                    string skillsScript = $@"
                        document.addEventListener('DOMContentLoaded', function() {{
                            const skillsContainer = document.querySelector('.skills-container .row');
                            const statusMessage = document.getElementById('statusMessage');
                            if (skillsContainer && statusMessage) {{
                                skillsContainer.innerHTML = `{skillsHtml.ToString().Replace("`", "\\`").Replace("'", "\\'").Replace("\r\n", "")}`;
                                statusMessage.innerHTML = '<i class=""fas fa-check-circle text-success me-2""></i>Successfully loaded {skills.Rows.Count} skills from database!';
                                console.log('Skills loaded from database:', skillsContainer.children.length);
                                
                                // Animate progress bars
                                setTimeout(() => {{
                                    const progressBars = document.querySelectorAll('.progress-bar');
                                    progressBars.forEach((bar, index) => {{
                                        const targetWidth = bar.getAttribute('aria-valuenow') + '%';
                                        bar.style.width = '0%';
                                        setTimeout(() => {{
                                            bar.style.width = targetWidth;
                                        }}, index * 100 + 300);
                                    }});
                                }}, 500);
                            }}
                        }});";
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "LoadSkills", skillsScript, true);
                }
                else
                {
                    ShowNoSkillsMessage();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading skills: {ex.Message}");
                ShowErrorMessage(ex.Message);
            }
        }

        private void TestConnection()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // Connection successful
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Database connection failed: {ex.Message}");
            }
        }

        private DataTable GetSkills()
        {
            string query = "SELECT SkillName, SkillCategory, ProficiencyLevel, IconClass, Description FROM Skills WHERE IsActive = 1 ORDER BY DisplayOrder, SkillName";
            
            DataTable dataTable = new DataTable();
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
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
                System.Diagnostics.Debug.WriteLine($"Database query error: {ex.Message}");
                throw;
            }
            return dataTable;
        }

        private void CreateSampleSkills()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    
                    string insertQuery = @"
                        -- Create Skills table if it doesn't exist
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

                        -- Insert sample skills if none exist
                        IF NOT EXISTS (SELECT * FROM Skills)
                        BEGIN
                            INSERT INTO Skills (SkillName, SkillCategory, ProficiencyLevel, IconClass, Description, DisplayOrder, IsActive) VALUES
                            ('C#', 'Programming', 90, 'fab fa-microsoft', 'Expert in C# programming language and .NET development', 1, 1),
                            ('ASP.NET', 'Framework', 85, 'fas fa-globe', 'Experienced in ASP.NET web development and MVC patterns', 2, 1),
                            ('JavaScript', 'Programming', 80, 'fab fa-js-square', 'Proficient in JavaScript and modern ES6+ features', 3, 1),
                            ('React', 'Framework', 75, 'fab fa-react', 'Skilled in React framework and component-based development', 4, 1),
                            ('SQL Server', 'Database', 85, 'fas fa-database', 'Expert in SQL Server database design and optimization', 5, 1),
                            ('HTML/CSS', 'Technology', 90, 'fab fa-html5', 'Expert in HTML5 and CSS3 with responsive design', 6, 1),
                            ('Bootstrap', 'Framework', 85, 'fab fa-bootstrap', 'Experienced in Bootstrap framework for responsive UI', 7, 1),
                            ('Flutter', 'Mobile', 70, 'fas fa-mobile-alt', 'Learning Flutter for cross-platform mobile development', 8, 1),
                            ('Python', 'Programming', 75, 'fab fa-python', 'Skilled in Python programming and data analysis', 9, 1),
                            ('Git', 'Technology', 80, 'fab fa-git-alt', 'Proficient in Git version control and collaboration', 10, 1),
                            ('Node.js', 'Technology', 70, 'fab fa-node-js', 'Experienced in Node.js backend development', 11, 1),
                            ('MongoDB', 'Database', 65, 'fas fa-leaf', 'Familiar with MongoDB NoSQL database operations', 12, 1);
                        END";
                    
                    using (SqlCommand command = new SqlCommand(insertQuery, connection))
                    {
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error creating sample skills: {ex.Message}");
                throw;
            }
        }

        private string GetCategoryColor(string category)
        {
            switch (category.ToLower())
            {
                case "mobile": return "text-success";
                case "programming": return "text-primary";
                case "framework": return "text-info";
                case "database": return "text-warning";
                case "technology": return "text-secondary";
                default: return "text-primary";
            }
        }

        private string GetBadgeColor(string category)
        {
            switch (category.ToLower())
            {
                case "mobile": return "bg-success";
                case "programming": return "bg-primary";
                case "framework": return "bg-info";
                case "database": return "bg-warning text-dark";
                case "technology": return "bg-secondary";
                default: return "bg-primary";
            }
        }

        private void ShowNoSkillsMessage()
        {
            string noSkillsScript = @"
                document.addEventListener('DOMContentLoaded', function() {
                    const skillsContainer = document.querySelector('.skills-container .row');
                    const statusMessage = document.getElementById('statusMessage');
                    if (skillsContainer && statusMessage) {
                        skillsContainer.innerHTML = `
                            <div class='col-12 text-center py-5'>
                                <div class='alert alert-info'>
                                    <i class='fas fa-info-circle fa-3x mb-3'></i>
                                    <h4>No Skills Found</h4>
                                    <p>No skills are currently available in the database.</p>
                                    <p class='text-muted'>Please add some skills from the admin panel.</p>
                                </div>
                            </div>
                        `;
                        statusMessage.innerHTML = '<i class=""fas fa-exclamation-triangle text-warning me-2""></i>No skills found in database';
                    }
                });";
            
            ClientScript.RegisterStartupScript(this.GetType(), "NoSkills", noSkillsScript, true);
        }

        private void ShowErrorMessage(string error)
        {
            string errorScript = $@"
                document.addEventListener('DOMContentLoaded', function() {{
                    const skillsContainer = document.querySelector('.skills-container .row');
                    const statusMessage = document.getElementById('statusMessage');
                    if (skillsContainer && statusMessage) {{
                        skillsContainer.innerHTML = `
                            <div class='col-12 text-center py-5'>
                                <div class='alert alert-danger'>
                                    <i class='fas fa-exclamation-triangle fa-3x mb-3'></i>
                                    <h4>Error Loading Skills</h4>
                                    <p>Unable to load skills from the database.</p>
                                    <p class='text-muted'>Error: {error.Replace("'", "\\'")}</p>
                                </div>
                            </div>
                        `;
                        statusMessage.innerHTML = '<i class=""fas fa-times-circle text-danger me-2""></i>Error: {error.Replace("'", "\\'")}';
                    }}
                }});";
            
            ClientScript.RegisterStartupScript(this.GetType(), "SkillsError", errorScript, true);
        }
    }
}