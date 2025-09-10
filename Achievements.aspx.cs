using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Achievements : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Set page title
            Page.Title = "Achievements & Certifications";
            
            if (!IsPostBack)
            {
                LoadAchievementsFromDatabase();
                LoadEducationFromDatabase();
            }
        }

        private void LoadAchievementsFromDatabase()
        {
            try
            {
                DataTable achievements = GetAchievementsData();
                if (achievements.Rows.Count > 0)
                {
                    LoadAchievementsGrid(achievements);
                }
                else
                {
                    ShowNoAchievementsMessage();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading achievements: {ex.Message}");
                ShowErrorMessage(ex.Message);
            }
        }

        private DataTable GetAchievementsData()
        {
            string query = "SELECT Title, Description, AchievementDate, Organization, Category FROM Achievements WHERE IsActive = 1 ORDER BY DisplayOrder, AchievementDate DESC";
            
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
            }
            return dataTable;
        }

        private void LoadAchievementsGrid(DataTable achievementsData)
        {
            StringBuilder achievementsHtml = new StringBuilder();
            
            foreach (DataRow row in achievementsData.Rows)
            {
                string title = row["Title"].ToString();
                string description = row["Description"].ToString();
                DateTime achievementDate = Convert.ToDateTime(row["AchievementDate"]);
                string organization = row["Organization"].ToString();
                string category = row["Category"].ToString();
                
                string formattedDate = achievementDate.ToString("MMM yyyy");
                string categoryIcon = GetCategoryIcon(category);
                string categoryColor = GetCategoryColor(category);
                
                achievementsHtml.AppendFormat(@"
                    <div class='col-lg-6 col-md-6 mb-4'>
                        <div class='card achievement-card h-100'>
                            <div class='card-body'>
                                <div class='d-flex justify-content-between align-items-start mb-3'>
                                    <div class='achievement-icon {0}'>
                                        <i class='{1} fa-2x'></i>
                                    </div>
                                    <span class='badge {2}'>{3}</span>
                                </div>
                                <h5 class='card-title'>{4}</h5>
                                <p class='card-text'>{5}</p>
                                <div class='achievement-meta mt-auto'>
                                    <div class='d-flex justify-content-between align-items-center'>
                                        <small class='text-muted'>
                                            <i class='fas fa-building me-1'></i>{6}
                                        </small>
                                        <small class='text-muted'>
                                            <i class='fas fa-calendar me-1'></i>{7}
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>",
                    categoryColor,
                    categoryIcon,
                    GetCategoryBadgeColor(category),
                    category,
                    title,
                    description,
                    organization,
                    formattedDate);
            }
            
            string achievementsScript = @"
                document.addEventListener('DOMContentLoaded', function() {
                    const achievementsContainer = document.querySelector('.achievements-container .row');
                    if (achievementsContainer) {
                        achievementsContainer.innerHTML = '" + achievementsHtml.ToString().Replace("'", "\\'") + @"';
                        console.log('Achievements loaded from database');
                        
                        // Animate achievement cards
                        const achievementCards = document.querySelectorAll('.achievement-card');
                        achievementCards.forEach((card, index) => {
                            setTimeout(() => {
                                card.style.opacity = '1';
                                card.style.transform = 'translateY(0)';
                            }, index * 150);
                        });
                    }
                });";
            
            ClientScript.RegisterStartupScript(this.GetType(), "LoadAchievements", achievementsScript, true);
        }

        private string GetCategoryIcon(string category)
        {
            switch (category.ToLower())
            {
                case "academic": return "fas fa-graduation-cap";
                case "certification": return "fas fa-certificate";
                case "competition": return "fas fa-trophy";
                case "technical": return "fas fa-code";
                case "leadership": return "fas fa-users";
                case "volunteer": return "fas fa-hands-helping";
                default: return "fas fa-award";
            }
        }

        private string GetCategoryColor(string category)
        {
            switch (category.ToLower())
            {
                case "academic": return "text-primary";
                case "certification": return "text-success";
                case "competition": return "text-warning";
                case "technical": return "text-info";
                case "leadership": return "text-danger";
                case "volunteer": return "text-secondary";
                default: return "text-primary";
            }
        }

        private string GetCategoryBadgeColor(string category)
        {
            switch (category.ToLower())
            {
                case "academic": return "bg-primary";
                case "certification": return "bg-success";
                case "competition": return "bg-warning text-dark";
                case "technical": return "bg-info";
                case "leadership": return "bg-danger";
                case "volunteer": return "bg-secondary";
                default: return "bg-primary";
            }
        }

        private void LoadEducationFromDatabase()
        {
            try
            {
                DataTable education = GetEducationData();
                if (education.Rows.Count > 0)
                {
                    StringBuilder educationHtml = new StringBuilder();
                    
                    foreach (DataRow row in education.Rows)
                    {
                        string degree = row["Degree"].ToString();
                        string institution = row["Institution"].ToString();
                        int startYear = Convert.ToInt32(row["StartYear"]);
                        int? endYear = row["EndYear"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["EndYear"]);
                        string grade = row["Grade"].ToString();
                        string fieldOfStudy = row["FieldOfStudy"].ToString();
                        string location = row["Location"].ToString();
                        
                        string yearRange = endYear.HasValue ? $"{startYear} - {endYear}" : $"{startYear} - Present";
                        
                        educationHtml.AppendFormat(@"
                            <div class='col-lg-6 col-md-6 mb-4'>
                                <div class='card h-100'>
                                    <div class='card-body'>
                                        <div class='d-flex justify-content-between align-items-start mb-3'>
                                            <h5 class='card-title mb-0'>{0}</h5>
                                            <span class='badge bg-success'>{1}</span>
                                        </div>
                                        <h6 class='card-subtitle mb-2 text-muted'>{2}</h6>
                                        {3}
                                        <div class='education-meta mt-3'>
                                            <small class='text-muted'>
                                                <i class='fas fa-calendar me-1'></i>{4}<br>
                                                {5}
                                                {6}
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>", 
                            degree, 
                            yearRange,
                            institution,
                            !string.IsNullOrEmpty(fieldOfStudy) ? $"<p class='card-text'><strong>Field:</strong> {fieldOfStudy}</p>" : "",
                            yearRange,
                            !string.IsNullOrEmpty(grade) ? $"<i class='fas fa-star me-1'></i>Grade: {grade}<br>" : "",
                            !string.IsNullOrEmpty(location) ? $"<i class='fas fa-map-marker-alt me-1'></i>{location}" : "");
                    }
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "LoadEducation", $@"
                        document.addEventListener('DOMContentLoaded', function() {{
                            const educationContainer = document.querySelector('.education-container .row');
                            if (educationContainer) {{
                                educationContainer.innerHTML = `{educationHtml.ToString().Replace("`", "\\`").Replace("\r\n", "")}`;
                            }}
                        }});
                    ", true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading education: {ex.Message}");
            }
        }

        private DataTable GetEducationData()
        {
            string query = "SELECT Degree, Institution, StartYear, EndYear, Grade, FieldOfStudy, Location FROM Education WHERE IsActive = 1 ORDER BY DisplayOrder, StartYear DESC";
            
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
            }
            return dataTable;
        }

        private void ShowNoAchievementsMessage()
        {
            string noDataScript = @"
                document.addEventListener('DOMContentLoaded', function() {
                    const achievementsContainer = document.querySelector('.achievements-container .row');
                    if (achievementsContainer) {
                        achievementsContainer.innerHTML = `
                            <div class='col-12 text-center py-5'>
                                <div class='alert alert-info'>
                                    <i class='fas fa-award fa-3x mb-3'></i>
                                    <h4>No Achievements Found</h4>
                                    <p>No achievements are currently available in the database.</p>
                                    <p class='text-muted'>Please add achievements from the admin panel.</p>
                                </div>
                            </div>
                        `;
                    }
                });";
            
            ClientScript.RegisterStartupScript(this.GetType(), "NoAchievements", noDataScript, true);
        }

        private void ShowErrorMessage(string error)
        {
            string errorScript = @"
                document.addEventListener('DOMContentLoaded', function() {
                    const achievementsContainer = document.querySelector('.achievements-container .row');
                    if (achievementsContainer) {
                        achievementsContainer.innerHTML = `
                            <div class='col-12 text-center py-5'>
                                <div class='alert alert-danger'>
                                    <i class='fas fa-exclamation-triangle fa-3x mb-3'></i>
                                    <h4>Error Loading Achievements</h4>
                                    <p>Unable to load achievements from the database.</p>
                                    <p class='text-muted'>Error: " + error.Replace("'", "\\'") + @"</p>
                                </div>
                            </div>
                        `;
                    }
                });";
            
            ClientScript.RegisterStartupScript(this.GetType(), "AchievementsError", errorScript, true);
        }
    }
}