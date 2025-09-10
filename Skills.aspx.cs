using System;
using System.Data;
using System.Text;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Skills : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSkillsByCategory();
            }
        }

        private void LoadSkillsByCategory()
        {
            try
            {
                DataTable skills = DatabaseHelper.GetSkills();
                
                if (skills.Rows.Count > 0)
                {
                    StringBuilder programmingHtml = new StringBuilder();
                    StringBuilder frameworkHtml = new StringBuilder();
                    StringBuilder mobileHtml = new StringBuilder();
                    StringBuilder databaseHtml = new StringBuilder();
                    StringBuilder technologyHtml = new StringBuilder();
                    
                    foreach (DataRow row in skills.Rows)
                    {
                        string skillName = row["SkillName"].ToString();
                        string category = row["SkillCategory"].ToString();
                        int proficiency = Convert.ToInt32(row["ProficiencyLevel"]);
                        string iconClass = row["IconClass"].ToString();
                        string description = row["Description"]?.ToString() ?? "";
                        
                        string skillHtml = CreateSkillCard(skillName, proficiency, iconClass, category, description);
                        
                        // Categorize skills
                        switch (category.ToLower())
                        {
                            case "programming":
                                programmingHtml.Append(skillHtml);
                                break;
                            case "framework":
                                frameworkHtml.Append(skillHtml);
                                break;
                            case "mobile":
                                mobileHtml.Append(skillHtml);
                                break;
                            case "database":
                                databaseHtml.Append(skillHtml);
                                break;
                            case "technology":
                            default:
                                technologyHtml.Append(skillHtml);
                                break;
                        }
                    }
                    
                    // Create the JavaScript code with proper escaping
                    string jsCode = @"
                        document.addEventListener('DOMContentLoaded', function() {
                            const programmingContainer = document.querySelector('#programmingSkillsRow');
                            const frameworkContainer = document.querySelector('#frameworkSkillsRow');
                            const mobileContainer = document.querySelector('#mobileSkillsRow');
                            const databaseContainer = document.querySelector('#databaseSkillsRow');
                            const technologyContainer = document.querySelector('#technologySkillsRow');
                            
                            if (programmingContainer) {
                                programmingContainer.innerHTML = `" + programmingHtml.ToString().Replace("`", "\\`").Replace("\r\n", "").Replace("'", "\\'") + @"`;
                                console.log('Programming skills loaded:', programmingContainer.children.length);
                            }
                            
                            if (frameworkContainer) {
                                frameworkContainer.innerHTML = `" + frameworkHtml.ToString().Replace("`", "\\`").Replace("\r\n", "").Replace("'", "\\'") + @"`;
                                console.log('Framework skills loaded:', frameworkContainer.children.length);
                            }
                            
                            if (mobileContainer) {
                                mobileContainer.innerHTML = `" + mobileHtml.ToString().Replace("`", "\\`").Replace("\r\n", "").Replace("'", "\\'") + @"`;
                                console.log('Mobile skills loaded:', mobileContainer.children.length);
                            }
                            
                            if (databaseContainer) {
                                databaseContainer.innerHTML = `" + databaseHtml.ToString().Replace("`", "\\`").Replace("\r\n", "").Replace("'", "\\'") + @"`;
                                console.log('Database skills loaded:', databaseContainer.children.length);
                            }
                            
                            if (technologyContainer) {
                                technologyContainer.innerHTML = `" + technologyHtml.ToString().Replace("`", "\\`").Replace("\r\n", "").Replace("'", "\\'") + @"`;
                                console.log('Technology skills loaded:', technologyContainer.children.length);
                            }
                            
                            // Animate progress bars after loading
                            setTimeout(function() {
                                const progressBars = document.querySelectorAll('.progress-bar');
                                console.log('Animating progress bars:', progressBars.length);
                                progressBars.forEach(function(bar) {
                                    const width = bar.style.width;
                                    bar.style.width = '0%';
                                    setTimeout(function() {
                                        bar.style.width = width;
                                    }, 200 + Math.random() * 300);
                                });
                            }, 300);
                            
                            console.log('All skills loaded successfully');
                        });";
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "LoadSkillsByCategory", jsCode, true);
                    
                    // Also update page statistics
                    UpdateSkillsStatistics(skills.Rows.Count, programmingHtml.Length > 0, frameworkHtml.Length > 0, 
                        mobileHtml.Length > 0, databaseHtml.Length > 0, technologyHtml.Length > 0);
                }
                else
                {
                    string noDataJs = @"
                        document.addEventListener('DOMContentLoaded', function() {
                            const containers = ['#programmingSkillsRow', '#frameworkSkillsRow', '#mobileSkillsRow', '#databaseSkillsRow', '#technologySkillsRow'];
                            containers.forEach(function(containerId) {
                                const container = document.querySelector(containerId);
                                if (container) {
                                    container.innerHTML = '<div class=""col-12 text-center""><div class=""alert alert-info""><i class=""fas fa-info-circle me-2""></i>No skills found in this category. Please add some skills from the admin panel.</div></div>';
                                }
                            });
                            console.log('No skills data found');
                        });";
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "NoSkillsFound", noDataJs, true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading skills: {ex.Message}");
                
                string errorJs = @"
                    document.addEventListener('DOMContentLoaded', function() {
                        const containers = ['#programmingSkillsRow', '#frameworkSkillsRow', '#mobileSkillsRow', '#databaseSkillsRow', '#technologySkillsRow'];
                        containers.forEach(function(containerId) {
                            const container = document.querySelector(containerId);
                            if (container) {
                                container.innerHTML = '<div class=""col-12 text-center""><div class=""alert alert-danger""><i class=""fas fa-exclamation-triangle me-2""></i>Error loading skills data. Please check the database connection.</div></div>';
                            }
                        });
                    });";
                
                ClientScript.RegisterStartupScript(this.GetType(), "SkillsError", errorJs, true);
            }
        }

        private string CreateSkillCard(string skillName, int proficiency, string iconClass, string category, string description)
        {
            // Get category-specific styling
            string categoryColor = GetCategoryColor(category);
            string categoryIcon = GetCategoryIcon(category);
            
            return $@"
                <div class='col-md-6 col-lg-4 mb-4'>
                    <div class='card h-100 text-center skill-card' data-category='{category.ToLower()}'>
                        <div class='card-body'>
                            <div class='skill-icon-container mb-3'>
                                <i class='{iconClass ?? categoryIcon} fa-3x {categoryColor}'></i>
                            </div>
                            <h5 class='card-title'>{skillName}</h5>
                            <div class='progress mt-3 mb-2' style='height: 10px;'>
                                <div class='progress-bar {GetProgressBarClass(proficiency)}' 
                                     role='progressbar' 
                                     style='width: {proficiency}%' 
                                     aria-valuenow='{proficiency}' 
                                     aria-valuemin='0' 
                                     aria-valuemax='100'>
                                </div>
                            </div>
                            <div class='d-flex justify-content-between align-items-center'>
                                <small class='text-muted'>
                                    <i class='{categoryIcon} me-1'></i>{category}
                                </small>
                                <small class='fw-bold {categoryColor}'>{proficiency}%</small>
                            </div>
                            {(!string.IsNullOrEmpty(description) ? $"<p class='card-text mt-2'><small class='text-muted'>{description}</small></p>" : "")}
                            <div class='skill-level-badge'>
                                <span class='badge {GetSkillLevelBadge(proficiency)}'>{GetSkillLevel(proficiency)}</span>
                            </div>
                        </div>
                    </div>
                </div>";
        }

        private void UpdateSkillsStatistics(int totalSkills, bool hasProgramming, bool hasFramework, bool hasMobile, bool hasDatabase, bool hasTechnology)
        {
            int categoriesCount = (hasProgramming ? 1 : 0) + (hasFramework ? 1 : 0) + (hasMobile ? 1 : 0) + (hasDatabase ? 1 : 0) + (hasTechnology ? 1 : 0);
            
            string statsScript = $@"
                document.addEventListener('DOMContentLoaded', function() {{
                    // Update skills statistics if containers exist
                    const statsElements = document.querySelectorAll('.stat-number');
                    if (statsElements.length > 0) {{
                        statsElements.forEach(function(element, index) {{
                            if (index === 0) element.textContent = '{totalSkills}';
                            if (index === 1) element.textContent = '{categoriesCount}';
                        }});
                    }}
                    
                    // Add category count badges
                    setTimeout(() => {{
                        updateCategoryCount('#programmingSkillsRow', 'Programming');
                        updateCategoryCount('#frameworkSkillsRow', 'Frameworks');
                        updateCategoryCount('#mobileSkillsRow', 'Mobile');
                        updateCategoryCount('#databaseSkillsRow', 'Database');
                        updateCategoryCount('#technologySkillsRow', 'Technology');
                    }}, 500);
                    
                    console.log('Skills statistics updated - Total: {totalSkills}, Categories: {categoriesCount}');
                }});
                
                function updateCategoryCount(containerId, categoryName) {{
                    const container = document.querySelector(containerId);
                    if (container) {{
                        const skillCount = container.children.length;
                        const header = container.closest('.mb-5')?.querySelector('h3');
                        if (header && skillCount > 0) {{
                            const existingBadge = header.querySelector('.badge');
                            if (existingBadge) existingBadge.remove();
                            header.innerHTML += ` <span class='badge bg-primary ms-2'>${{skillCount}}</span>`;
                        }}
                    }}
                }}";
            
            ClientScript.RegisterStartupScript(this.GetType(), "UpdateStats", statsScript, true);
        }

        private string GetCategoryColor(string category)
        {
            switch (category.ToLower())
            {
                case "programming": return "text-primary";
                case "framework": return "text-success";
                case "mobile": return "text-info";
                case "database": return "text-warning";
                case "technology": return "text-danger";
                default: return "text-secondary";
            }
        }

        private string GetCategoryIcon(string category)
        {
            switch (category.ToLower())
            {
                case "programming": return "fas fa-code";
                case "framework": return "fas fa-layer-group";
                case "mobile": return "fas fa-mobile-alt";
                case "database": return "fas fa-database";
                case "technology": return "fas fa-cogs";
                default: return "fas fa-star";
            }
        }

        private string GetProgressBarClass(int proficiency)
        {
            if (proficiency >= 90) return "bg-success";
            if (proficiency >= 75) return "bg-info";
            if (proficiency >= 60) return "bg-warning";
            if (proficiency >= 40) return "bg-primary";
            return "bg-secondary";
        }

        private string GetSkillLevelBadge(int proficiency)
        {
            if (proficiency >= 90) return "bg-success";
            if (proficiency >= 75) return "bg-info";
            if (proficiency >= 60) return "bg-warning text-dark";
            if (proficiency >= 40) return "bg-primary";
            return "bg-secondary";
        }

        private string GetSkillLevel(int proficiency)
        {
            if (proficiency >= 90) return "Expert";
            if (proficiency >= 75) return "Advanced";
            if (proficiency >= 60) return "Intermediate";
            if (proficiency >= 40) return "Beginner";
            return "Learning";
        }
    }
}