using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class SimpleLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Simple page load
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();

                System.Diagnostics.Debug.WriteLine($"SimpleLogin: Username='{username}', Password='{password}'");

                if (username.Equals("Ariyan", StringComparison.OrdinalIgnoreCase) && password == "Ariyan123")
                {
                    // Set session
                    Session["AdminLoggedIn"] = true;
                    Session["AdminUsername"] = "Ariyan";
                    Session["AdminFullName"] = "Ariyan Aftab Spandan";
                    Session["LoginTime"] = DateTime.Now;

                    System.Diagnostics.Debug.WriteLine("SimpleLogin: Authentication successful, attempting redirect");

                    // Show success message
                    ShowMessage("? Authentication successful! Redirecting...", "alert-success");

                    // Try direct redirect
                    Response.Redirect("Admin.aspx");
                }
                else
                {
                    ShowMessage("? Invalid credentials. Use: Ariyan / Ariyan123", "alert-danger");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"SimpleLogin error: {ex.Message}");
                ShowMessage($"? Error: {ex.Message}", "alert-danger");
            }
        }

        protected void btnDirectRedirect_Click(object sender, EventArgs e)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("SimpleLogin: Direct redirect button clicked");

                // Set session without authentication
                Session["AdminLoggedIn"] = true;
                Session["AdminUsername"] = "Ariyan";
                Session["AdminFullName"] = "Ariyan Aftab Spandan (Direct)";
                Session["LoginTime"] = DateTime.Now;

                // Direct redirect
                Response.Redirect("Admin.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Direct redirect error: {ex.Message}");
                ShowMessage($"? Direct redirect error: {ex.Message}", "alert-danger");
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