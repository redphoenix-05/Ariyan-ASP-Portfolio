using System;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                    // Add debug output to see if this code is running
                    System.Diagnostics.Debug.WriteLine("Default.aspx Page_Load started at: " + DateTime.Now);
                    
                    LoadPortfolioInfo();
                    
                    System.Diagnostics.Debug.WriteLine("Default.aspx Page_Load completed successfully");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error in Default.aspx Page_Load: " + ex.Message);
                    
                    // Show error on page for debugging
                    Response.Write($"<div style='color: red; padding: 20px; font-family: Arial;'>");
                    Response.Write($"<h2>Debug Information</h2>");
                    Response.Write($"<p><strong>Error:</strong> {ex.Message}</p>");
                    Response.Write($"<p><strong>Time:</strong> {DateTime.Now}</p>");
                    Response.Write($"<p><strong>Page:</strong> Default.aspx</p>");
                    Response.Write($"<p><a href='Test.aspx'>Go to Test Page</a></p>");
                    Response.Write($"</div>");
                }
            }
        }

        private void LoadPortfolioInfo()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("LoadPortfolioInfo started");
                
                // Find controls using FindControl method
                Literal litFullName = (Literal)FindControl("litFullName");
                Literal litTagline = (Literal)FindControl("litTagline");
                System.Web.UI.WebControls.Image imgProfile = (System.Web.UI.WebControls.Image)FindControl("imgProfile");
                
                System.Diagnostics.Debug.WriteLine($"Controls found - litFullName: {litFullName != null}, litTagline: {litTagline != null}, imgProfile: {imgProfile != null}");
                
                if (litFullName != null)
                {
                    litFullName.Text = "Ariyan Aftab Spandan";
                    System.Diagnostics.Debug.WriteLine("Full name set successfully");
                }
                
                if (litTagline != null)
                {
                    litTagline.Text = "App Developer | Mobile & Web Specialist";
                    System.Diagnostics.Debug.WriteLine("Tagline set successfully");
                }
                
                // Add a visible indicator that the page loaded
                if (litFullName != null)
                {
                    // Add a small debug indicator
                    litFullName.Text += $" <!-- Loaded at {DateTime.Now:HH:mm:ss} -->";
                }
                
                System.Diagnostics.Debug.WriteLine("LoadPortfolioInfo completed successfully");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in LoadPortfolioInfo: {ex.Message}");
                throw; // Re-throw to be caught by Page_Load
            }
        }
    }
}