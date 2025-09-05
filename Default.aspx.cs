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
                System.Web.UI.WebControls.Image imgProfile = (System.Web.UI.WebControls.Image)FindControl("imgProfile");
                
                if (litFullName != null)
                    litFullName.Text = "Ariyan Rahman";
                
                if (litTagline != null)
                    litTagline.Text = "Full Stack Developer | ASP.NET Specialist";
                
                // These will be loaded from database once we set it up
                /* TODO: Implement database loading
                string query = "SELECT TOP 1 FullName, Tagline, ProfileImagePath FROM PortfolioInfo";
                DataTable dt = DatabaseHelper.ExecuteQuery(query);
                
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    if (litFullName != null)
                        litFullName.Text = row["FullName"].ToString();
                    if (litTagline != null)
                        litTagline.Text = row["Tagline"].ToString();
                    
                    if (!string.IsNullOrEmpty(row["ProfileImagePath"].ToString()) && imgProfile != null)
                    {
                        imgProfile.ImageUrl = row["ProfileImagePath"].ToString();
                    }
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