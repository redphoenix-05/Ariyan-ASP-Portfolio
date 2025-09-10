using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Education : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Education";
            
            if (!IsPostBack)
            {
                LoadEducationFromDatabase();
            }
        }

        private void LoadEducationFromDatabase()
        {
            try
            {
                DataTable education = GetEducationData();
                if (education.Rows.Count > 0)
                {
                    LoadEducationTimeline(education);
                }
                else
                {
                    ShowNoEducationMessage();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading education: {ex.Message}");
                ShowErrorMessage(ex.Message);
            }
        }

        private DataTable GetEducationData()
        {
            string query = "SELECT Degree, Institution, StartYear, EndYear, Grade, FieldOfStudy, Description, Location FROM Education WHERE IsActive = 1 ORDER BY DisplayOrder, StartYear DESC";
            
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

        private void LoadEducationTimeline(DataTable education)
        {
            StringBuilder educationHtml = new StringBuilder();
            int itemIndex = 0;
            
            foreach (DataRow row in education.Rows)
            {
                string degree = row["Degree"].ToString();
                string institution = row["Institution"].ToString();
                int startYear = Convert.ToInt32(row["StartYear"]);
                int? endYear = row["EndYear"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["EndYear"]);
                string grade = row["Grade"].ToString();
                string fieldOfStudy = row["FieldOfStudy"].ToString();
                string location = row["Location"].ToString();
                string description = row["Description"]?.ToString() ?? "";
                
                string yearRange = endYear.HasValue ? $"{startYear} - {endYear}" : $"{startYear} - Present";
                
                // Alternate left and right positioning
                bool isLeftSide = itemIndex % 2 == 0;
                string positionClass = isLeftSide ? "education-left" : "education-right";
                
                // Get education level icon and color
                string levelInfo = GetEducationLevelInfo(degree);
                
                educationHtml.AppendFormat(@"
                    <div class='education-item {0}' data-aos='fade-{8}' data-aos-delay='{9}'>
                        <div class='education-date'>
                            <div class='date-badge'>
                                <i class='fas fa-calendar-alt me-2'></i>{1}
                            </div>
                        </div>
                        <div class='education-content'>
                            <div class='education-header'>
                                <div class='education-icon'>
                                    <i class='{10}'></i>
                                </div>
                                <div class='education-title-section'>
                                    <h4 class='education-degree'>{2}</h4>
                                    <h5 class='education-institution'>
                                        <i class='fas fa-university me-2'></i>{3}
                                    </h5>
                                </div>
                            </div>
                            <div class='education-details'>
                                {4}
                                {5}
                                {6}
                                {7}
                            </div>
                        </div>
                    </div>", 
                    positionClass,                                                          // 0
                    yearRange,                                                             // 1
                    degree,                                                                // 2
                    institution,                                                           // 3
                    !string.IsNullOrEmpty(fieldOfStudy) ? $"<div class='education-field'><i class='fas fa-book me-2'></i><strong>Field:</strong> {fieldOfStudy}</div>" : "", // 4
                    !string.IsNullOrEmpty(grade) ? $"<div class='education-grade'><i class='fas fa-star me-2'></i><strong>Grade:</strong> <span class='grade-value'>{grade}</span></div>" : "", // 5
                    !string.IsNullOrEmpty(location) ? $"<div class='education-location'><i class='fas fa-map-marker-alt me-2'></i><strong>Location:</strong> {location}</div>" : "", // 6
                    !string.IsNullOrEmpty(description) ? $"<div class='education-description mt-3'><p class='text-muted'>{description}</p></div>" : "", // 7
                    isLeftSide ? "right" : "left",                                        // 8 - Animation direction
                    itemIndex * 200,                                                      // 9 - Animation delay
                    levelInfo                                                              // 10 - Icon class
                );
                
                itemIndex++;
            }
            
            string jsCode = @"
                document.addEventListener('DOMContentLoaded', function() {
                    const educationContainer = document.querySelector('#educationTimeline');
                    if (educationContainer) {
                        educationContainer.innerHTML = `" + educationHtml.ToString().Replace("`", "\\`").Replace("\r\n", "").Replace("'", "\\'") + @"`;
                        
                        console.log('Education timeline loaded with', educationContainer.children.length, 'items');
                        
                        // Initialize animations
                        initEducationAnimations();
                
                        // Update statistics
                        updateEducationStats(" + education.Rows.Count + @");
                    } else {
                        console.error('Education timeline container not found!');
                    }
                });
                
                function initEducationAnimations() {
                    // Animate timeline items
                    const items = document.querySelectorAll('.education-item');
                    items.forEach((item, index) => {
                        setTimeout(() => {
                            item.style.opacity = '1';
                            item.style.transform = 'translateY(0)';
                        }, index * 300);
                    });
                
                    // Animate timeline line
                    const timeline = document.querySelector('.education-timeline::before');
                    if (timeline) {
                        setTimeout(() => {
                            timeline.style.transform = 'scaleY(1)';
                        }, 500);
                    }
                
                    console.log('Education animations initialized');
                }
                
                function updateEducationStats(count) {
                    // Update any statistics displays
                    const statElements = document.querySelectorAll('[data-education-stat]');
                    statElements.forEach(el => {
                        el.textContent = count;
                    });
                }";
            
            ClientScript.RegisterStartupScript(this.GetType(), "LoadEducation", jsCode, true);
            
            // Add education statistics
            AddEducationStatistics(education);
        }

        private void AddEducationStatistics(DataTable education)
        {
            try
            {
                int totalEducation = education.Rows.Count;
                int completedEducation = 0;
                int ongoingEducation = 0;
                int totalYears = 0;
                
                foreach (DataRow row in education.Rows)
                {
                    int startYear = Convert.ToInt32(row["StartYear"]);
                    int? endYear = row["EndYear"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["EndYear"]);
                    
                    if (endYear.HasValue)
                    {
                        completedEducation++;
                        totalYears += endYear.Value - startYear;
                    }
                    else
                    {
                        ongoingEducation++;
                        totalYears += DateTime.Now.Year - startYear;
                    }
                }
                
                string statsScript = $@"
                    document.addEventListener('DOMContentLoaded', function() {{
                        // Add education statistics to the page if stats container exists
                        const statsContainer = document.querySelector('.education-stats');
                        if (statsContainer) {{
                            statsContainer.innerHTML = `
                                <div class='row text-center mb-5'>
                                    <div class='col-md-3'>
                                        <div class='stat-card'>
                                            <h3 class='stat-number text-primary'>{totalEducation}</h3>
                                            <p class='stat-label'>Total Education</p>
                                        </div>
                                    </div>
                                    <div class='col-md-3'>
                                        <div class='stat-card'>
                                            <h3 class='stat-number text-success'>{completedEducation}</h3>
                                            <p class='stat-label'>Completed</p>
                                        </div>
                                    </div>
                                    <div class='col-md-3'>
                                        <div class='stat-card'>
                                            <h3 class='stat-number text-warning'>{ongoingEducation}</h3>
                                            <p class='stat-label'>Ongoing</p>
                                        </div>
                                    </div>
                                    <div class='col-md-3'>
                                        <div class='stat-card'>
                                            <h3 class='stat-number text-info'>{totalYears}+</h3>
                                            <p class='stat-label'>Years of Learning</p>
                                        </div>
                                    </div>
                                </div>
                            `;
                            
                            console.log('Education statistics added');
                        }}
                    }});";
            
                ClientScript.RegisterStartupScript(this.GetType(), "EducationStats", statsScript, true);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error adding education statistics: {ex.Message}");
            }
        }

        private string GetEducationLevelInfo(string degree)
        {
            string degreeLower = degree.ToLower();
            
            if (degreeLower.Contains("phd") || degreeLower.Contains("doctorate"))
                return "fas fa-user-graduate text-danger";
            else if (degreeLower.Contains("master") || degreeLower.Contains("msc") || degreeLower.Contains("mba"))
                return "fas fa-graduation-cap text-success";
            else if (degreeLower.Contains("bachelor") || degreeLower.Contains("bsc") || degreeLower.Contains("engineering"))
                return "fas fa-university text-primary";
            else if (degreeLower.Contains("diploma") || degreeLower.Contains("certificate"))
                return "fas fa-certificate text-warning";
            else if (degreeLower.Contains("hsc") || degreeLower.Contains("higher secondary"))
                return "fas fa-school text-info";
            else if (degreeLower.Contains("ssc") || degreeLower.Contains("secondary"))
                return "fas fa-book text-secondary";
            else
                return "fas fa-graduation-cap text-primary";
        }

        private void ShowNoEducationMessage()
        {
            string noDataScript = @"
                document.addEventListener('DOMContentLoaded', function() {
                    const timelineContainer = document.querySelector('.education-timeline');
                    if (timelineContainer) {
                        timelineContainer.innerHTML = `
                            <div class='timeline-item'>
                                <div class='timeline-content'>
                                    <div class='alert alert-info text-center'>
                                        <i class='fas fa-graduation-cap fa-3x mb-3'></i>
                                        <h4>No Education Records Found</h4>
                                        <p>No education records are currently available in the database.</p>
                                        <p class='text-muted'>Please add education records from the admin panel.</p>
                                    </div>
                                </div>
                            </div>
                        `;
                    }
                });";
            
            ClientScript.RegisterStartupScript(this.GetType(), "NoEducation", noDataScript, true);
        }

        private void ShowErrorMessage(string error)
        {
            string errorScript = @"
                document.addEventListener('DOMContentLoaded', function() {
                    const timelineContainer = document.querySelector('.education-timeline');
                    if (timelineContainer) {
                        timelineContainer.innerHTML = `
                            <div class='timeline-item'>
                                <div class='timeline-content'>
                                    <div class='alert alert-danger text-center'>
                                        <i class='fas fa-exclamation-triangle fa-3x mb-3'></i>
                                        <h4>Error Loading Education</h4>
                                        <p>Unable to load education records from the database.</p>
                                        <p class='text-muted'>Error: " + error.Replace("'", "\\'") + @"</p>
                                    </div>
                                </div>
                            </div>
                        `;
                    }
                });";
            
            ClientScript.RegisterStartupScript(this.GetType(), "EducationError", errorScript, true);
        }
    }
}