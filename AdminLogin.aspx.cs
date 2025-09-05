using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;
using WebApplication1.App_Code;

namespace WebApplication1
{
    public partial class AdminLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If user is already authenticated, redirect to admin dashboard
            if (Request.IsAuthenticated)
            {
                Response.Redirect("~/Admin/Dashboard.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    string username = txtUsername.Text.Trim();
                    string password = txtPassword.Text;
                    
                    if (ValidateUser(username, password))
                    {
                        // Update last login date
                        UpdateLastLoginDate(username);
                        
                        // Create authentication ticket
                        FormsAuthentication.SetAuthCookie(username, false);
                        
                        // Store user info in session
                        Session["AdminUsername"] = username;
                        Session["AdminLoginTime"] = DateTime.Now;
                        
                        // Redirect to admin dashboard
                        Response.Redirect("~/Admin/Dashboard.aspx");
                    }
                    else
                    {
                        ShowError("Invalid username or password. Please try again.");
                        
                        // Log failed login attempt
                        LogFailedLoginAttempt(username);
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the actual error but show a generic message
                System.Diagnostics.Debug.WriteLine($"Login error: {ex.Message}");
                ShowError("An error occurred during login. Please try again later.");
            }
            finally
            {
                // Reset button state
                btnLogin.Text = "Login";
                btnLogin.Enabled = true;
            }
        }

        private bool ValidateUser(string username, string password)
        {
            try
            {
                string query = @"
                    SELECT UserId, Username, PasswordHash 
                    FROM AdminUsers 
                    WHERE Username = @Username";
                
                SqlParameter[] parameters = {
                    new SqlParameter("@Username", username)
                };
                
                DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
                
                if (dt.Rows.Count == 1)
                {
                    string storedHash = dt.Rows[0]["PasswordHash"].ToString();
                    
                    // For initial setup, check if password is plain text "Admin@123"
                    if (storedHash == "AQAAAAEAACcQAAAAEF/1JayQT+VQpVJPW9KqSrVzI+Uy8q5jKjGjGJfAQg/9FJvHzDvHzDvHzDvHzDvH" && password == "Admin@123")
                    {
                        // Update with proper hash
                        string newHash = DatabaseHelper.HashPassword(password);
                        UpdatePasswordHash(username, newHash);
                        return true;
                    }
                    
                    // Verify password hash
                    return DatabaseHelper.VerifyPassword(password, storedHash);
                }
                
                return false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"User validation error: {ex.Message}");
                return false;
            }
        }

        private void UpdatePasswordHash(string username, string newHash)
        {
            try
            {
                string query = "UPDATE AdminUsers SET PasswordHash = @PasswordHash WHERE Username = @Username";
                
                SqlParameter[] parameters = {
                    new SqlParameter("@PasswordHash", newHash),
                    new SqlParameter("@Username", username)
                };
                
                DatabaseHelper.ExecuteNonQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Password hash update error: {ex.Message}");
            }
        }

        private void UpdateLastLoginDate(string username)
        {
            try
            {
                string query = "UPDATE AdminUsers SET LastLoginDate = @LastLoginDate WHERE Username = @Username";
                
                SqlParameter[] parameters = {
                    new SqlParameter("@LastLoginDate", DateTime.Now),
                    new SqlParameter("@Username", username)
                };
                
                DatabaseHelper.ExecuteNonQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Last login update error: {ex.Message}");
            }
        }

        private void LogFailedLoginAttempt(string username)
        {
            try
            {
                // You can implement a failed login attempts table here
                // For now, just log to debug output
                string ipAddress = GetClientIPAddress();
                System.Diagnostics.Debug.WriteLine(
                    $"Failed login attempt - Username: {username}, IP: {ipAddress}, Time: {DateTime.Now}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Failed login logging error: {ex.Message}");
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

        private void ShowError(string message)
        {
            litError.Text = message;
            pnlError.Visible = true;
        }
    }
}