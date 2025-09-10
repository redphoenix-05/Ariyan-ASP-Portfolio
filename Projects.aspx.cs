using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Projects : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjectsFromDatabase();
            }
        }

        private void LoadProjectsFromDatabase()
        {
            try
            {
                DataTable projects = GetAllProjects();
                if (projects.Rows.Count > 0)
                {
                    LoadAllProjects(projects);
                }
                else
                {
                    ShowNoProjectsMessage();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading projects: {ex.Message}");
                ShowErrorMessage(ex.Message);
            }
        }

        private DataTable GetAllProjects()
        {
            string query = "SELECT Title, Description, TechStack, GitHubLink, DemoLink, ProjectType, Status FROM Projects WHERE IsActive = 1 ORDER BY DisplayOrder, CreatedDate DESC";
            
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

        private void LoadAllProjects(DataTable allProjects)
        {
            StringBuilder projectsHtml = new StringBuilder();
            
            foreach (DataRow row in allProjects.Rows)
            {
                string projectCard = CreateProjectCard(row);
                projectsHtml.Append(projectCard);
            }
            
            string allProjectsScript = @"
                document.addEventListener('DOMContentLoaded', function() {
                    const projectsContainer = document.querySelector('.projects-container .row');
                    if (projectsContainer) {
                        projectsContainer.innerHTML = '" + projectsHtml.ToString().Replace("'", "\\'") + @"';
                        console.log('Projects loaded from database');
                        initProjectFilters();
                    }
                });
                
                function initProjectFilters() {
                    // Add filter functionality
                    const filterButtons = document.querySelectorAll('[data-filter]');
                    filterButtons.forEach(button => {
                        button.addEventListener('click', function() {
                            const filter = this.getAttribute('data-filter');
                            filterProjects(filter);
                            updateActiveFilter(this);
                        });
                    });
                }
                
                function filterProjects(category) {
                    const allProjects = document.querySelectorAll('.project-card');
                    allProjects.forEach(project => {
                        if (category === 'all' || project.getAttribute('data-category') === category) {
                            project.closest('.col-lg-4, .col-md-6').style.display = 'block';
                        } else {
                            project.closest('.col-lg-4, .col-md-6').style.display = 'none';
                        }
                    });
                }
                
                function updateActiveFilter(activeButton) {
                    const filterButtons = document.querySelectorAll('[data-filter]');
                    filterButtons.forEach(btn => btn.classList.remove('active'));
                    activeButton.classList.add('active');
                }";
            
            ClientScript.RegisterStartupScript(this.GetType(), "LoadAllProjects", allProjectsScript, true);
        }

        private string CreateProjectCard(DataRow row)
        {
            string title = row["Title"].ToString();
            string description = row["Description"].ToString();
            string techStack = row["TechStack"].ToString();
            string githubLink = row["GitHubLink"]?.ToString() ?? "#";
            string demoLink = row["DemoLink"]?.ToString() ?? "#";
            string projectType = row["ProjectType"].ToString();
            string status = row["Status"].ToString();
            
            // Generate project-specific styling
            string typeIcon = GetProjectTypeIcon(projectType);
            string typeColor = GetProjectTypeColor(projectType);
            string statusBadge = GetStatusBadge(status);
            string imageUrl = GetProjectImage(projectType, title);
            
            // Create tech stack badges
            string techBadges = CreateTechStackBadges(techStack);
            
            return $@"
                <div class='col-lg-4 col-md-6 mb-4'>
                    <div class='card h-100 project-card shadow-hover' data-category='{projectType.ToLower()}'>
                        <div class='position-relative'>
                            <img src='{imageUrl}' class='card-img-top project-image' alt='{title}' style='height: 220px; object-fit: cover;'>
                            <div class='project-overlay'>
                                <div class='project-type-badge'>
                                    <i class='{typeIcon} me-1'></i>{projectType}
                                </div>
                                {statusBadge}
                            </div>
                        </div>
                        <div class='card-body d-flex flex-column'>
                            <div class='d-flex justify-content-between align-items-start mb-2'>
                                <h5 class='card-title project-title'>{title}</h5>
                                <i class='{typeIcon} {typeColor} fs-4'></i>
                            </div>
                            <p class='card-text project-description flex-grow-1'>{description}</p>
                            
                            <div class='tech-stack-section mb-3'>
                                <h6 class='tech-stack-title'>
                                    <i class='fas fa-tools me-1'></i>Technology Stack
                                </h6>
                                <div class='tech-badges'>
                                    {techBadges}
                                </div>
                            </div>
                        </div>
                        <div class='card-footer bg-transparent border-0 pt-0'>
                            <div class='d-flex justify-content-between align-items-center'>
                                <a href='{githubLink}' class='btn btn-outline-dark btn-sm project-btn' target='_blank' {(githubLink == "#" ? "onclick='return false;' disabled" : "")}>
                                    <i class='fab fa-github me-1'></i>
                                    {(githubLink == "#" ? "Private" : "View Code")}
                                </a>
                                <a href='{demoLink}' class='btn btn-primary btn-sm project-btn' target='_blank' {(demoLink == "#" ? "onclick='return false;' disabled" : "")}>
                                    <i class='fas fa-external-link-alt me-1'></i>
                                    {(demoLink == "#" ? "Coming Soon" : "Live Demo")}
                                </a>
                            </div>
                        </div>
                    </div>
                </div>";
        }

        private string CreateTechStackBadges(string techStack)
        {
            if (string.IsNullOrEmpty(techStack)) return "";
            
            StringBuilder badges = new StringBuilder();
            string[] technologies = techStack.Split(',');
            
            foreach (string tech in technologies)
            {
                string trimmedTech = tech.Trim();
                if (!string.IsNullOrEmpty(trimmedTech))
                {
                    string badgeColor = GetTechBadgeColor(trimmedTech);
                    badges.AppendFormat("<span class='badge {0} me-1 mb-1'>{1}</span>", badgeColor, trimmedTech);
                }
            }
            
            return badges.ToString();
        }

        private void ShowNoProjectsMessage()
        {
            string noDataScript = @"
                document.addEventListener('DOMContentLoaded', function() {
                    const projectsContainer = document.querySelector('.projects-container .row');
                    if (projectsContainer) {
                        projectsContainer.innerHTML = `
                            <div class='col-12 text-center py-5'>
                                <div class='alert alert-info border-0 shadow-lg'>
                                    <i class='fas fa-folder-open fa-4x mb-4 text-info'></i>
                                    <h3>No Projects Found</h3>
                                    <p class='lead mb-3'>No projects are currently available in the database.</p>
                                    <p class='text-muted'>Please add some projects from the admin panel to showcase your work.</p>
                                </div>
                            </div>
                        `;
                    }
                });";
            
            ClientScript.RegisterStartupScript(this.GetType(), "NoProjects", noDataScript, true);
        }

        private void ShowErrorMessage(string error)
        {
            string errorScript = @"
                document.addEventListener('DOMContentLoaded', function() {
                    const projectsContainer = document.querySelector('.projects-container .row');
                    if (projectsContainer) {
                        projectsContainer.innerHTML = `
                            <div class='col-12 text-center py-5'>
                                <div class='alert alert-danger border-0 shadow-lg'>
                                    <i class='fas fa-exclamation-triangle fa-4x mb-4 text-danger'></i>
                                    <h3>Error Loading Projects</h3>
                                    <p class='lead mb-3'>Unable to load projects from the database.</p>
                                    <p class='text-muted'>Error: " + error.Replace("'", "\\'") + @"</p>
                                </div>
                            </div>
                        `;
                    }
                });";
            
            ClientScript.RegisterStartupScript(this.GetType(), "ProjectsError", errorScript, true);
        }

        #region Helper Methods

        private string GetProjectTypeIcon(string projectType)
        {
            switch (projectType.ToLower())
            {
                case "mobile": return "fas fa-mobile-alt";
                case "web": return "fas fa-globe";
                case "ml": case "machine learning": return "fas fa-brain";
                case "desktop": return "fas fa-desktop";
                case "api": return "fas fa-plug";
                default: return "fas fa-code";
            }
        }

        private string GetProjectTypeColor(string projectType)
        {
            switch (projectType.ToLower())
            {
                case "mobile": return "text-success";
                case "web": return "text-primary";
                case "ml": case "machine learning": return "text-danger";
                case "desktop": return "text-secondary";
                case "api": return "text-warning";
                default: return "text-info";
            }
        }

        private string GetStatusBadge(string status)
        {
            switch (status.ToLower())
            {
                case "completed":
                    return "<span class='badge bg-success status-badge'>Completed</span>";
                case "in progress":
                    return "<span class='badge bg-warning text-dark status-badge'>In Progress</span>";
                case "planned":
                    return "<span class='badge bg-info status-badge'>Planned</span>";
                case "paused":
                    return "<span class='badge bg-secondary status-badge'>Paused</span>";
                default:
                    return "<span class='badge bg-light text-dark status-badge'>Unknown</span>";
            }
        }

        private string GetProjectImage(string projectType, string title)
        {
            switch (projectType.ToLower())
            {
                case "mobile":
                    return $"https://via.placeholder.com/400x220/28a745/ffffff?text={title.Replace(" ", "+")}";
                case "web":
                    return $"https://via.placeholder.com/400x220/007bff/ffffff?text={title.Replace(" ", "+")}";
                case "ml":
                case "machine learning":
                    return $"https://via.placeholder.com/400x220/dc3545/ffffff?text={title.Replace(" ", "+")}";
                default:
                    return $"https://via.placeholder.com/400x220/6c757d/ffffff?text={title.Replace(" ", "+")}";
            }
        }

        private string GetTechBadgeColor(string tech)
        {
            string techLower = tech.ToLower();
            
            if (techLower.Contains("react") || techLower.Contains("javascript")) return "bg-info";
            if (techLower.Contains("python") || techLower.Contains("django")) return "bg-success";
            if (techLower.Contains("java") || techLower.Contains("android")) return "bg-warning text-dark";
            if (techLower.Contains("c#") || techLower.Contains(".net")) return "bg-primary";
            if (techLower.Contains("node") || techLower.Contains("express")) return "bg-success";
            if (techLower.Contains("flutter") || techLower.Contains("dart")) return "bg-info";
            
            return "bg-secondary";
        }

        #endregion
    }
}