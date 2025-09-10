using System;
using System.Web;
using System.Web.Security;
using System.Web.UI;

namespace WebApplication1
{
    public partial class AdminLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Only check for existing login if we're not processing a login attempt
            if (!IsPostBack && Request.QueryString["returnUrl"] == null)
            {
                // Check if user is already logged in
                if (IsUserAlreadyLoggedIn())
                {
                    System.Diagnostics.Debug.WriteLine("User already logged in, redirecting to Admin.aspx");
                    Response.Redirect("Admin.aspx");
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
                bool sessionValid = Session.SessionID != null;
                
                System.Diagnostics.Debug.WriteLine($"AdminLogin Auth Check - LoggedIn: {sessionLoggedIn}, HasUsername: {hasUsername}, SessionValid: {sessionValid}");
                
                return sessionLoggedIn && hasUsername && sessionValid;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"AdminLogin auth check error: {ex.Message}");
                return false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                // Get form values directly from server controls
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();
                bool rememberMe = chkRememberMe.Checked;

                System.Diagnostics.Debug.WriteLine($"Login attempt - Username: '{username}', HasPassword: {!string.IsNullOrEmpty(password)}");

                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
                {
                    ShowMessage("Please enter both username and password.", "alert-warning");
                    return;
                }

                // Simple hardcoded authentication
                if (username.Equals("Ariyan", StringComparison.OrdinalIgnoreCase) && password == "Ariyan123")
                {
                    System.Diagnostics.Debug.WriteLine($"Authentication successful for user: {username}");
                    
                    // Set session variables
                    Session["AdminLoggedIn"] = true;
                    Session["AdminUsername"] = "Ariyan";
                    Session["AdminFullName"] = "Ariyan Aftab Spandan";
                    Session["LoginTime"] = DateTime.Now;
                    Session.Timeout = 30; // 30 minutes

                    // Clear form fields
                    txtUsername.Text = "";
                    txtPassword.Text = "";
                    chkRememberMe.Checked = false;

                    System.Diagnostics.Debug.WriteLine("Attempting redirect to AdminSimple.aspx");
                    
                    // Direct redirect - no complex logic
                    Response.Redirect("AdminSimple.aspx");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"Authentication failed for user: {username}");
                    
                    // Failed login - show error
                    ShowMessage("Invalid username or password. Use: Ariyan / Ariyan123", "alert-danger");
                    
                    // Clear password field for security
                    txtPassword.Text = "";
                }
            }
            catch (Exception ex)
            {
                string errorMsg = $"Login error: {ex.Message}";
                System.Diagnostics.Debug.WriteLine(errorMsg);
                ShowMessage(errorMsg, "alert-danger");
            }
        }

        protected void btnTestRedirect_Click(object sender, EventArgs e)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("Test redirect button clicked - attempting redirect to AdminSimple.aspx");
                
                // Set test session data
                Session["AdminLoggedIn"] = true;
                Session["AdminUsername"] = "Ariyan";
                Session["AdminFullName"] = "Ariyan Aftab Spandan (Test)";
                Session["LoginTime"] = DateTime.Now;
                
                // Test redirect
                Response.Redirect("AdminSimple.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Test redirect error: {ex.Message}");
                ShowMessage($"Test redirect error: {ex.Message}", "alert-danger");
            }
        }

        private void CreateAuthenticationTicket(string username, bool persistent)
        {
            try
            {
                FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                    1, // version
                    username, // name
                    DateTime.Now, // issue time
                    DateTime.Now.AddMinutes(30), // expiration
                    persistent, // persistent
                    "admin" // user data
                );

                string encryptedTicket = FormsAuthentication.Encrypt(ticket);
                var authCookie = new System.Web.HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                
                if (persistent)
                {
                    authCookie.Expires = DateTime.Now.AddDays(7);
                }
                
                Response.Cookies.Add(authCookie);
                System.Diagnostics.Debug.WriteLine("Authentication cookie created successfully");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error creating authentication cookie: {ex.Message}");
            }
        }

        private void ShowMessage(string message, string cssClass)
        {
            pnlMessage.Visible = true;
            litMessage.Text = message;
            pnlMessage.CssClass = cssClass;
        }
    }
}