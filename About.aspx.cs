using System;
using System.Data;
using System.Web.UI;
using WebApplication1.App_Code;

namespace WebApplication1
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPortfolioInfo();
                LoadCounts();
                LoadSkills();
            }
        }

        private void LoadPortfolioInfo()
        {
            try
            {
                string query = @"
                    SELECT TOP 1 FullName, Tagline, AboutDescription, ProfileImagePath, 
                           Email, PhoneNumber, Address, ResumeFilePath,
                           LinkedInProfile, GitHubProfile, TwitterProfile, FacebookProfile
                    FROM PortfolioInfo";
                
                DataTable dt = DatabaseHelper.ExecuteQuery(query);
                
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    
                    // Basic info
                    litFullName.Text = row["FullName"].ToString();
                    litTagline.Text = row["Tagline"].ToString();
                    litAboutDescription.Text = row["AboutDescription"].ToString().Replace("\n", "<br />");
                    
                    // Profile image
                    if (!string.IsNullOrEmpty(row["ProfileImagePath"].ToString()))
                    {
                        imgProfileLarge.ImageUrl = row["ProfileImagePath"].ToString();
                    }
                    
                    // Contact information
                    if (!string.IsNullOrEmpty(row["Email"].ToString()))
                    {
                        litEmail.Text = row["Email"].ToString();
                        divEmail.Visible = true;
                    }
                    
                    if (!string.IsNullOrEmpty(row["PhoneNumber"].ToString()))
                    {
                        litPhone.Text = row["PhoneNumber"].ToString();
                        divPhone.Visible = true;
                    }
                    
                    if (!string.IsNullOrEmpty(row["Address"].ToString()))
                    {
                        litAddress.Text = row["Address"].ToString();
                        divAddress.Visible = true;
                    }
                    
                    // Resume link
                    if (!string.IsNullOrEmpty(row["ResumeFilePath"].ToString()))
                    {
                        lnkResume.NavigateUrl = row["ResumeFilePath"].ToString();
                        lnkResume.Visible = true;
                    }
                    
                    // Social links
                    if (!string.IsNullOrEmpty(row["LinkedInProfile"].ToString()))
                    {
                        lnkLinkedIn.NavigateUrl = row["LinkedInProfile"].ToString();
                        lnkLinkedIn.Visible = true;
                    }
                    
                    if (!string.IsNullOrEmpty(row["GitHubProfile"].ToString()))
                    {
                        lnkGitHub.NavigateUrl = row["GitHubProfile"].ToString();
                        lnkGitHub.Visible = true;
                    }
                    
                    if (!string.IsNullOrEmpty(row["TwitterProfile"].ToString()))
                    {
                        lnkTwitter.NavigateUrl = row["TwitterProfile"].ToString();
                        lnkTwitter.Visible = true;
                    }
                    
                    if (!string.IsNullOrEmpty(row["FacebookProfile"].ToString()))
                    {
                        lnkFacebook.NavigateUrl = row["FacebookProfile"].ToString();
                        lnkFacebook.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error
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
                litProjectsCount.Text = Convert.ToInt32(projectCount).ToString();

                // Get skills count
                string skillQuery = "SELECT COUNT(*) FROM Skills WHERE IsActive = 1";
                object skillCount = DatabaseHelper.ExecuteScalar(skillQuery);
                litSkillsCount.Text = Convert.ToInt32(skillCount).ToString();

                // Get achievements count
                string achievementQuery = "SELECT COUNT(*) FROM Achievements WHERE IsActive = 1";
                object achievementCount = DatabaseHelper.ExecuteScalar(achievementQuery);
                litAchievementsCount.Text = Convert.ToInt32(achievementCount).ToString();

                // Get certificates count
                string certificateQuery = "SELECT COUNT(*) FROM Certificates WHERE IsActive = 1";
                object certificateCount = DatabaseHelper.ExecuteScalar(certificateQuery);
                litCertificatesCount.Text = Convert.ToInt32(certificateCount).ToString();
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine($"Error loading counts: {ex.Message}");
                litProjectsCount.Text = litSkillsCount.Text = litAchievementsCount.Text = litCertificatesCount.Text = "0";
            }
        }

        private void LoadSkills()
        {
            try
            {
                // Load Technical Skills
                string techQuery = @"
                    SELECT SkillName, ProficiencyLevel, IconClass 
                    FROM Skills 
                    WHERE IsActive = 1 AND SkillType = 'Technical'
                    ORDER BY ProficiencyLevel DESC";
                
                DataTable techSkills = DatabaseHelper.ExecuteQuery(techQuery);
                rptTechnicalSkills.DataSource = techSkills;
                rptTechnicalSkills.DataBind();

                // Load Soft Skills
                string softQuery = @"
                    SELECT SkillName, ProficiencyLevel, IconClass 
                    FROM Skills 
                    WHERE IsActive = 1 AND SkillType = 'Soft'
                    ORDER BY ProficiencyLevel DESC";
                
                DataTable softSkills = DatabaseHelper.ExecuteQuery(softQuery);
                rptSoftSkills.DataSource = softSkills;
                rptSoftSkills.DataBind();
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine($"Error loading skills: {ex.Message}");
            }
        }
    }
}