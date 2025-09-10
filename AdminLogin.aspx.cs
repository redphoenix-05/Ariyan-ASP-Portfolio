using System;
using System.Configuration;
using System.Web.UI;

namespace WebApplication1
{
    public partial class AdminLogin : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is already logged in
                if (IsUserAlreadyLoggedIn())
                {
                    Response.Redirect("AdminSimple.aspx");
                    return;
                }
            }
        }

        private bool IsUserAlreadyLoggedIn()
        {
            try 
            {
                bool sessionLoggedIn = Session["AdminLoggedIn"] != null && Convert.ToBoolean(Session["AdminLoggedIn"]);
                bool hasUsername = !string.IsNullOrEmpty(Session["AdminUsername"]?.ToString());
                
                return sessionLoggedIn && hasUsername;
            }
            catch
            {
                return false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();

                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
                {
                    ShowMessage("Please enter both username and password.", "alert-warning");
                    return;
                }

                // Validate credentials from database or configuration
                if (ValidateCredentials(username, password))
                {
                    // Set session variables
                    Session["AdminLoggedIn"] = true;
                    Session["AdminUsername"] = username;
                    Session["AdminFullName"] = GetFullName(username);
                    Session["LoginTime"] = DateTime.Now;
                    Session.Timeout = 30; // 30 minutes

                    // Clear form fields
                    txtUsername.Text = "";
                    txtPassword.Text = "";

                    // Redirect to admin panel
                    Response.Redirect("AdminSimple.aspx");
                }
                else
                {
                    // Failed login - show error
                    ShowMessage("Invalid username or password.", "alert-danger");
                    
                    // Clear password field for security
                    txtPassword.Text = "";
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Login error: {ex.Message}", "alert-danger");
            }
        }

        private bool ValidateCredentials(string username, string password)
        {
            // For now, use simple validation. You can enhance this with database lookup
            // or more sophisticated authentication methods
            return username.Equals("admin", StringComparison.OrdinalIgnoreCase) && password == "admin123";
        }

        private string GetFullName(string username)
        {
            // You can enhance this to get full name from database
            if (username.Equals("admin", StringComparison.OrdinalIgnoreCase))
                return "Portfolio Administrator";
            
            return username;
        }

        private void ShowMessage(string message, string cssClass)
        {
            pnlMessage.Visible = true;
            litMessage.Text = message;
            pnlMessage.CssClass = cssClass;
        }
    }
}