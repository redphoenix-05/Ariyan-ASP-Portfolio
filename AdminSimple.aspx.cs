using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class AdminSimple : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserInfo();
            }
        }

        private void LoadUserInfo()
        {
            // Check if user is authenticated
            bool isAuthenticated = Session["AdminLoggedIn"] != null && Convert.ToBoolean(Session["AdminLoggedIn"]);
            
            if (isAuthenticated)
            {
                string username = Session["AdminUsername"]?.ToString() ?? "Admin";
                string fullName = Session["AdminFullName"]?.ToString() ?? username;
                DateTime loginTime = Session["LoginTime"] != null ? Convert.ToDateTime(Session["LoginTime"]) : DateTime.Now;
                
                litUsername.Text = fullName;
                litUserDisplay.Text = username;
                litLoginTime.Text = loginTime.ToString("MMM dd, yyyy 'at' hh:mm tt");
                
                // Truncate session ID for better display
                string sessionId = Session.SessionID ?? "N/A";
                litSessionId.Text = sessionId.Length > 8 ? sessionId.Substring(0, 8) + "..." : sessionId;
            }
            else
            {
                litUsername.Text = "Guest User";
                litUserDisplay.Text = "Please login first";
                litLoginTime.Text = "Not authenticated";
                litSessionId.Text = "No active session";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session data
            Session.Clear();
            Session.Abandon();
            
            // Redirect to login page
            Response.Redirect("AdminLogin.aspx");
        }
    }
}