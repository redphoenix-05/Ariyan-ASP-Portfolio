using System;
using System.Data;
using System.Text;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Achievements : Page
    {
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
                DataTable achievements = DatabaseHelper.GetAchievements();
                if (achievements.Rows.Count > 0)
                {
                    StringBuilder achievementsHtml = new StringBuilder();
                    
                    foreach (DataRow row in achievements.Rows)
                    {
                        string title = row["Title"].ToString();
                        string description = row["Description"].ToString();
                        DateTime date = Convert.ToDateTime(row["AchievementDate"]);
                        string organization = row["Organization"].ToString();
                        string category = row["Category"].ToString();
                        
                        string categoryBadge = GetCategoryBadge(category);
                        
                        achievementsHtml.AppendFormat(@"
                            <div class='col-lg-6 col-md-6 mb-4'>
                                <div class='card h-100'>
                                    <div class='card-body'>
                                        <div class='d-flex justify-content-between align-items-start mb-3'>
                                            <h5 class='card-title mb-0'>{0}</h5>
                                            {1}
                                        </div>
                                        <p class='card-text'>{2}</p>
                                        <div class='achievement-meta'>
                                            <small class='text-muted'>
                                                <i class='fas fa-building me-1'></i>{3}<br>
                                                <i class='fas fa-calendar me-1'></i>{4}
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>", 
                            title, categoryBadge, description, organization, date.ToString("MMMM yyyy"));
                    }
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "LoadAchievements", $@"
                        document.addEventListener('DOMContentLoaded', function() {{
                            const achievementsContainer = document.querySelector('.achievements-container .row');
                            if (achievementsContainer) {{
                                achievementsContainer.innerHTML = `{achievementsHtml.ToString().Replace("`", "\\`").Replace("\r\n", "")}`;
                            }}
                        }});
                    ", true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading achievements: {ex.Message}");
            }
        }

        private void LoadEducationFromDatabase()
        {
            try
            {
                DataTable education = DatabaseHelper.GetEducation();
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

        private string GetCategoryBadge(string category)
        {
            switch (category?.ToLower())
            {
                case "academic":
                    return "<span class='badge bg-primary'>Academic</span>";
                case "professional":
                    return "<span class='badge bg-success'>Professional</span>";
                case "competition":
                    return "<span class='badge bg-warning'>Competition</span>";
                case "certification":
                    return "<span class='badge bg-info'>Certification</span>";
                default:
                    return "<span class='badge bg-secondary'>Other</span>";
            }
        }
    }
}