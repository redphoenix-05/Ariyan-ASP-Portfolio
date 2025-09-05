using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPortfolioInfo();
            }
        }

        private void LoadPortfolioInfo()
        {
            try
            {
                // Find controls using FindControl method
                Literal litFullName = (Literal)FindControl("litFullName");
                Literal litTagline = (Literal)FindControl("litTagline");
                Literal litAboutDescription = (Literal)FindControl("litAboutDescription");
                
                if (litFullName != null)
                    litFullName.Text = "Ariyan Aftab Spandan";
                
                if (litTagline != null)
                    litTagline.Text = "App Developer | Mobile & Web Specialist";
                
                if (litAboutDescription != null)
                    litAboutDescription.Text = @"I am a passionate app developer specializing in creating innovative mobile and web applications. 
                    With expertise in Android, iOS, and cross-platform development, I transform ideas into powerful, user-friendly applications 
                    that make a difference. My focus is on delivering high-quality solutions that provide excellent user experiences across all platforms.
                    
                    <br><br>I have experience working with modern technologies including React Native, Flutter, ASP.NET, and cloud services. 
                    I enjoy tackling complex problems and creating elegant solutions that meet both user needs and business objectives.";
                
                // Sample stats - these will be loaded from database later
                Literal litProjectsCount = (Literal)FindControl("litProjectsCount");
                Literal litSkillsCount = (Literal)FindControl("litSkillsCount");
                Literal litAchievementsCount = (Literal)FindControl("litAchievementsCount");
                Literal litCertificatesCount = (Literal)FindControl("litCertificatesCount");
                
                if (litProjectsCount != null) litProjectsCount.Text = "8";
                if (litSkillsCount != null) litSkillsCount.Text = "15";
                if (litAchievementsCount != null) litAchievementsCount.Text = "5";
                if (litCertificatesCount != null) litCertificatesCount.Text = "12";
                
                /* TODO: Implement database loading
                string query = @"
                    SELECT TOP 1 FullName, Tagline, AboutDescription, ProfileImagePath, 
                           Email, PhoneNumber, Address, ResumeFilePath,
                           LinkedInProfile, GitHubProfile, TwitterProfile, FacebookProfile
                    FROM PortfolioInfo";
                
                DataTable dt = DatabaseHelper.ExecuteQuery(query);
                
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    
                    // Load all portfolio information from database
                    // Implementation will be added when database is connected
                }
                */
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine($"Error loading portfolio info: {ex.Message}");
            }
        }
    }
}