using System;
using System.Data;
using System.Text;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    LoadDynamicContent();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error in Default.aspx: {ex.Message}");
                    
                    // Set fallback content
                    litFullName.Text = "Ariyan Aftab Spandan";
                    litTagline.Text = "App & Web Developer | ML Enthusiast";
                }
            }
        }

        private void LoadDynamicContent()
        {
            try
            {
                // Set basic content first (static fallback)
                litFullName.Text = "Ariyan Aftab Spandan";
                litTagline.Text = "App & Web Developer | ML Enthusiast";
                
                // Load dynamic statistics
                LoadProjectStats();
                
                // Load featured skills for homepage
                LoadFeaturedSkills();
                
                // Load featured projects
                LoadFeaturedProjects();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading dynamic content: {ex.Message}");
            }
        }

        private void LoadProjectStats()
        {
            try
            {
                DataTable stats = DatabaseHelper.GetProjectStats();
                if (stats.Rows.Count > 0)
                {
                    DataRow row = stats.Rows[0];
                    
                    // Update the stat counters with real data
                    string statsScript = $@"
                        document.addEventListener('DOMContentLoaded', function() {{
                            try {{
                                updateStatCounter('[data-count=""8""]', {row["MobileApps"]});
                                updateStatCounter('[data-count=""15""]', {row["Technologies"]});
                                updateStatCounter('[data-count=""5""]', {row["Achievements"]});
                                updateStatCounter('[data-count=""12""]', {row["TotalProjects"]});
                                console.log('Stats updated from database');
                            }} catch(e) {{
                                console.log('Using default stats');
                            }}
                        }});
                        
                        function updateStatCounter(selector, newValue) {{
                            const element = document.querySelector(selector);
                            if (element && newValue > 0) {{
                                element.setAttribute('data-count', newValue);
                                element.textContent = newValue;
                            }}
                        }}";
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "UpdateStats", statsScript, true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading project stats: {ex.Message}");
            }
        }

        private void LoadFeaturedSkills()
        {
            try
            {
                DataTable skills = DatabaseHelper.GetSkills();
                if (skills.Rows.Count > 0)
                {
                    StringBuilder skillsHtml = new StringBuilder();
                    int count = 0;
                    
                    foreach (DataRow row in skills.Rows)
                    {
                        if (count >= 6) break; // Show only top 6 skills on homepage
                        
                        string skillName = row["SkillName"].ToString();
                        string category = row["SkillCategory"].ToString();
                        int proficiency = Convert.ToInt32(row["ProficiencyLevel"]);
                        string iconClass = row["IconClass"].ToString();
                        
                        // Generate color based on category
                        string cardColor = GetCategoryColor(category);
                        
                        skillsHtml.AppendFormat(@"
                            <div class='col-md-6 col-lg-4 mb-4'>
                                <div class='card h-100 text-center'>
                                    <div class='card-body'>
                                        <i class='{0} fa-3x {1} mb-3'></i>
                                        <h5 class='card-title'>{2}</h5>
                                        <div class='progress mt-3'>
                                            <div class='progress-bar' role='progressbar' style='width: {3}%' aria-valuenow='{3}' aria-valuemin='0' aria-valuemax='100'>
                                                {3}%
                                            </div>
                                        </div>
                                        <p class='card-text mt-2'><small class='text-muted'>{4}</small></p>
                                    </div>
                                </div>
                            </div>", 
                            iconClass, cardColor, skillName, proficiency, category);
                        
                        count++;
                    }
                    
                    // Inject dynamic skills into the page
                    string skillsScript = $@"
                        document.addEventListener('DOMContentLoaded', function() {{
                            const skillsContainer = document.querySelector('.skills-section .row');
                            if (skillsContainer) {{
                                const existingCards = skillsContainer.querySelectorAll('.col-md-6');
                                existingCards.forEach(card => card.remove());
                                skillsContainer.insertAdjacentHTML('beforeend', `{skillsHtml.ToString().Replace("`", "\\`").Replace("'", "\\'")}`.replace(/\\n\\s+/g, ''));
                                console.log('Dynamic skills loaded');
                                
                                // Animate progress bars
                                setTimeout(() => {{
                                    const progressBars = skillsContainer.querySelectorAll('.progress-bar');
                                    progressBars.forEach(bar => {{
                                        const width = bar.style.width;
                                        bar.style.width = '0%';
                                        setTimeout(() => {{
                                            bar.style.width = width;
                                        }}, 100);
                                    }};
                                }}, 500);
                            }}
                        }});";
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "LoadSkills", skillsScript, true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading featured skills: {ex.Message}");
            }
        }

        private void LoadFeaturedProjects()
        {
            try
            {
                DataTable projects = DatabaseHelper.GetFeaturedProjects();
                if (projects.Rows.Count > 0)
                {
                    StringBuilder projectsHtml = new StringBuilder();
                    
                    foreach (DataRow row in projects.Rows)
                    {
                        string title = row["Title"].ToString();
                        string description = row["Description"].ToString();
                        string techStack = row["TechStack"].ToString();
                        string githubLink = row["GitHubLink"].ToString();
                        string demoLink = row["DemoLink"].ToString();
                        string projectType = row["ProjectType"].ToString();
                        string status = row["Status"].ToString();
                        
                        // Generate placeholder image based on project type
                        string imageUrl = GetProjectImage(projectType);
                        string statusBadge = GetStatusBadge(status);
                        
                        projectsHtml.AppendFormat(@"
                            <div class='col-lg-4 col-md-6 mb-4'>
                                <div class='card h-100'>
                                    <img src='{0}' class='card-img-top' alt='{1}' style='height: 200px; object-fit: cover;'>
                                    <div class='card-body d-flex flex-column'>
                                        <h5 class='card-title'>{1}</h5>
                                        <p class='card-text flex-grow-1'>{2}</p>
                                        <div class='mb-2'>
                                            <small class='text-muted'>
                                                <strong>Tech Stack:</strong> {3}
                                            </small>
                                        </div>
                                        <div class='mb-2'>
                                            {4}
                                        </div>
                                    </div>
                                    <div class='card-footer bg-transparent'>
                                        <div class='d-flex justify-content-between'>
                                            <a href='{5}' class='btn btn-outline-dark btn-sm' target='_blank'>
                                                <i class='fab fa-github me-1'></i>Code
                                            </a>
                                            <a href='{6}' class='btn btn-primary btn-sm' {7}>
                                                <i class='fas fa-external-link-alt me-1'></i>Demo
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>", 
                            imageUrl, title, description, techStack, statusBadge, 
                            githubLink != "#" ? githubLink : "#",
                            demoLink != "#" ? demoLink : "#",
                            (demoLink == "#") ? "onclick='return false;' class='disabled'" : "");
                    }
                    
                    // Inject dynamic projects into the page
                    string projectsScript = $@"
                        document.addEventListener('DOMContentLoaded', function() {{
                            const projectsContainer = document.querySelector('.services-section .row');
                            if (projectsContainer) {{
                                const existingCards = projectsContainer.querySelectorAll('.col-lg-4');
                                existingCards.forEach(card => card.remove());
                                projectsContainer.insertAdjacentHTML('beforeend', `{projectsHtml.ToString().Replace("`", "\\`").Replace("'", "\\'")}`.replace(/\\n\\s+/g, ''));
                                console.log('Dynamic projects loaded');
                            }}
                        }});";
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "LoadProjects", projectsScript, true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading featured projects: {ex.Message}");
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

        private string GetProjectImage(string projectType)
        {
            switch (projectType.ToLower())
            {
                case "mobile": return "https://via.placeholder.com/400x200/007bff/ffffff?text=Mobile+App";
                case "web": return "https://via.placeholder.com/400x200/28a745/ffffff?text=Web+App";
                case "ml": return "https://via.placeholder.com/400x200/dc3545/ffffff?text=ML+Project";
                default: return "https://via.placeholder.com/400x200/6c757d/ffffff?text=Project";
            }
        }

        private string GetStatusBadge(string status)
        {
            switch (status.ToLower())
            {
                case "completed":
                    return "<span class='badge bg-success'>Completed</span>";
                case "in progress":
                    return "<span class='badge bg-warning text-dark'>In Progress</span>";
                case "planned":
                    return "<span class='badge bg-info'>Planned</span>";
                default:
                    return "<span class='badge bg-secondary'>Unknown</span>";
            }
        }
    }
}