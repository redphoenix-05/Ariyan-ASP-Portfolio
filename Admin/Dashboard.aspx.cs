using System;
using System.Data;
using System.Web.Security;
using System.Web.UI;

namespace WebApplication1.Admin
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is authenticated
            if (!Request.IsAuthenticated)
            {
                Response.Redirect("~/AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            try
            {
                // Load admin info
                string adminUsername = Session["AdminUsername"]?.ToString() ?? User.Identity.Name;
                litAdminName.Text = adminUsername;
                litWelcomeName.Text = adminUsername;

                // Load session info
                if (Session["AdminLoginTime"] != null)
                {
                    DateTime loginTime = (DateTime)Session["AdminLoginTime"];
                    litCurrentSession.Text = loginTime.ToString("MMM dd, yyyy HH:mm");
                }

                // Load last login (previous login)
                LoadLastLoginInfo(adminUsername);

                // Load IP address
                litIPAddress.Text = GetClientIPAddress();
                litLastActivity.Text = DateTime.Now.ToString("MMM dd, yyyy HH:mm");

                // Load statistics
                LoadStatistics();

                // Load recent messages
                LoadRecentMessages();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Dashboard load error: {ex.Message}");
            }
        }

        private void LoadLastLoginInfo(string username)
        {
            try
            {
                string query = "SELECT LastLoginDate FROM AdminUsers WHERE Username = @Username";
                var parameters = new System.Data.SqlClient.SqlParameter[]
                {
                    new System.Data.SqlClient.SqlParameter("@Username", username)
                };

                object result = DatabaseHelper.ExecuteScalar(query, parameters);
                if (result != null && result != DBNull.Value)
                {
                    DateTime lastLogin = Convert.ToDateTime(result);
                    litLastLogin.Text = lastLogin.ToString("MMM dd, yyyy HH:mm");
                }
                else
                {
                    litLastLogin.Text = "First time login";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Last login info error: {ex.Message}");
                litLastLogin.Text = "Unknown";
            }
        }

        private void LoadStatistics()
        {
            try
            {
                // Projects count
                string projectQuery = "SELECT COUNT(*) FROM Projects WHERE IsActive = 1";
                object projectCount = DatabaseHelper.ExecuteScalar(projectQuery);
                litProjectsCount.Text = Convert.ToInt32(projectCount).ToString();

                // Skills count
                string skillQuery = "SELECT COUNT(*) FROM Skills WHERE IsActive = 1";
                object skillCount = DatabaseHelper.ExecuteScalar(skillQuery);
                litSkillsCount.Text = Convert.ToInt32(skillCount).ToString();

                // Achievements count
                string achievementQuery = "SELECT COUNT(*) FROM Achievements WHERE IsActive = 1";
                object achievementCount = DatabaseHelper.ExecuteScalar(achievementQuery);
                litAchievementsCount.Text = Convert.ToInt32(achievementCount).ToString();

                // Messages count (total and unread)
                string totalMessagesQuery = "SELECT COUNT(*) FROM ContactMessages";
                object totalMessages = DatabaseHelper.ExecuteScalar(totalMessagesQuery);
                litMessagesCount.Text = Convert.ToInt32(totalMessages).ToString();

                string unreadQuery = "SELECT COUNT(*) FROM ContactMessages WHERE IsRead = 0";
                object unreadCount = DatabaseHelper.ExecuteScalar(unreadQuery);
                int unread = Convert.ToInt32(unreadCount);
                
                if (unread > 0)
                {
                    litUnreadCount.Text = $" <span class=\"badge bg-danger\">{unread}</span>";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Statistics load error: {ex.Message}");
                // Set default values
                litProjectsCount.Text = "0";
                litSkillsCount.Text = "0";
                litAchievementsCount.Text = "0";
                litMessagesCount.Text = "0";
            }
        }

        private void LoadRecentMessages()
        {
            try
            {
                string query = @"
                    SELECT TOP 5 MessageId, Name, Email, Subject, ReceivedDate, IsRead
                    FROM ContactMessages 
                    ORDER BY ReceivedDate DESC";

                DataTable dt = DatabaseHelper.ExecuteQuery(query);

                if (dt.Rows.Count > 0)
                {
                    rptRecentMessages.DataSource = dt;
                    rptRecentMessages.DataBind();
                    pnlNoMessages.Visible = false;
                }
                else
                {
                    pnlNoMessages.Visible = true;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Recent messages load error: {ex.Message}");
                pnlNoMessages.Visible = true;
            }
        }

        private string GetClientIPAddress()
        {
            string ipAddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (string.IsNullOrEmpty(ipAddress) || ipAddress.ToLower() == "unknown")
            {
                ipAddress = Request.ServerVariables["REMOTE_ADDR"];
            }

            if (string.IsNullOrEmpty(ipAddress))
            {
                ipAddress = Request.UserHostAddress;
            }

            return ipAddress ?? "Unknown";
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            try
            {
                // Clear session
                Session.Clear();
                Session.Abandon();

                // Sign out
                FormsAuthentication.SignOut();

                // Redirect to login page
                Response.Redirect("~/AdminLogin.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Logout error: {ex.Message}");
                Response.Redirect("~/AdminLogin.aspx");
            }
        }
    }
}