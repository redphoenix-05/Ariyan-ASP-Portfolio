using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class AdminTest : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is authenticated
                bool sessionValid = Session["AdminLoggedIn"] != null && Convert.ToBoolean(Session["AdminLoggedIn"]);
                
                if (!sessionValid)
                {
                    // Not authenticated, redirect to login
                    Response.Redirect("AdminLogin.aspx?returnUrl=" + Request.Url.PathAndQuery);
                    return;
                }
                
                // Load user information
                LoadUserInfo();
            }
        }
        
        private void LoadUserInfo()
        {
            try
            {
                // Display session information
                litUsername.Text = Session["AdminUsername"]?.ToString() ?? "Not Available";
                litUserId.Text = "N/A (No Database)";
                litFullName.Text = Session["AdminFullName"]?.ToString() ?? "Not Available";
                litLoginTime.Text = Session["LoginTime"]?.ToString() ?? "Not Available";
                
                // Display authentication status
                bool sessionValid = Session["AdminLoggedIn"] != null && Convert.ToBoolean(Session["AdminLoggedIn"]);
                litSessionValid.Text = sessionValid ? "? Valid" : "? Invalid";
                litFormsAuth.Text = User.Identity.IsAuthenticated ? "? Valid" : "? Not Required";
                litSessionId.Text = Session.SessionID ?? "Not Available";
                
                // Add JavaScript confirmation
                string script = @"
                    document.addEventListener('DOMContentLoaded', function() {
                        console.log('AdminTest page loaded successfully');
                        console.log('Session Valid: " + sessionValid + @"');
                        console.log('Username: " + (Session["AdminUsername"]?.ToString() ?? "null") + @"');
                        
                        // Auto-redirect to Admin.aspx after 3 seconds
                        setTimeout(function() {
                            window.location.href = 'Admin.aspx';
                        }, 3000);
                    });";
                
                ClientScript.RegisterStartupScript(this.GetType(), "TestPageLoaded", script, true);
            }
            catch (Exception ex)
            {
                litUsername.Text = "Error: " + ex.Message;
                System.Diagnostics.Debug.WriteLine($"AdminTest LoadUserInfo error: {ex.Message}");
            }
        }
    }
}