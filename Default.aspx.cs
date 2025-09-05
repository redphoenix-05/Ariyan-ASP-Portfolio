using System;
using System.Data;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Default : Page
    {
        public int ProjectsCount { get; set; }
        public int SkillsCount { get; set; }
        public int AchievementsCount { get; set; }
        public int CertificatesCount { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPortfolioInfo();
                LoadCounts();
                LoadFeaturedSkills();
                LoadFeaturedProjects();
            }
        }

        private void LoadPortfolioInfo()
        {
            try
            {
                string query = "SELECT TOP 1 FullName, Tagline, ProfileImagePath FROM PortfolioInfo";
                DataTable dt = DatabaseHelper.ExecuteQuery(query);
                
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    litFullName.Text = row["FullName"].ToString();
                    litTagline.Text = row["Tagline"].ToString();
                    
                    if (!string.IsNullOrEmpty(row["ProfileImagePath"].ToString()))
                    {
                        imgProfile.ImageUrl = row["ProfileImagePath"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error (implement logging as needed)
                System.Diagnostics.Debug.WriteLine($"Error loading portfolio info: {ex.Message}");
            }
        }

        private void LoadCounts()
        {
            try
            {
                // Get projects count
                string projectQuery = "SELECT COUNT(*) FROM Projects WHERE IsActive = 1";
                object projectCount = DatabaseHelper.ExecuteScalar(projectQuery);
                ProjectsCount = Convert.ToInt32(projectCount);

                // Get skills count
                string skillQuery = "SELECT COUNT(*) FROM Skills WHERE IsActive = 1";
                object skillCount = DatabaseHelper.ExecuteScalar(skillQuery);
                SkillsCount = Convert.ToInt32(skillCount);

                // Get achievements count
                string achievementQuery = "SELECT COUNT(*) FROM Achievements WHERE IsActive = 1";
                object achievementCount = DatabaseHelper.ExecuteScalar(achievementQuery);
                AchievementsCount = Convert.ToInt32(achievementCount);

                // Get certificates count
                string certificateQuery = "SELECT COUNT(*) FROM Certificates WHERE IsActive = 1";
                object certificateCount = DatabaseHelper.ExecuteScalar(certificateQuery);
                CertificatesCount = Convert.ToInt32(certificateCount);
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine($"Error loading counts: {ex.Message}");
                ProjectsCount = SkillsCount = AchievementsCount = CertificatesCount = 0;
            }
        }

        private void LoadFeaturedSkills()
        {
            try
            {
                string query = @"
                    SELECT TOP 6 SkillName, SkillType, ProficiencyLevel, IconClass 
                    FROM Skills 
                    WHERE IsActive = 1 
                    ORDER BY ProficiencyLevel DESC";
                
                DataTable dt = DatabaseHelper.ExecuteQuery(query);
                rptFeaturedSkills.DataSource = dt;
                rptFeaturedSkills.DataBind();
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine($"Error loading featured skills: {ex.Message}");
            }
        }

        private void LoadFeaturedProjects()
        {
            try
            {
                string query = @"
                    SELECT TOP 3 ProjectId, Title, Description, TechStack, GitHubLink, DemoLink, ImagePath 
                    FROM Projects 
                    WHERE IsActive = 1 
                    ORDER BY DisplayOrder, CreatedDate DESC";
                
                DataTable dt = DatabaseHelper.ExecuteQuery(query);
                rptFeaturedProjects.DataSource = dt;
                rptFeaturedProjects.DataBind();
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine($"Error loading featured projects: {ex.Message}");
            }
        }
    }
}}