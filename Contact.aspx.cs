using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using WebApplication1.App_Code;

namespace WebApplication1
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadContactInfo();
            }
        }

        private void LoadContactInfo()
        {
            try
            {
                string query = @"
                    SELECT TOP 1 Email, PhoneNumber, Address, 
                           LinkedInProfile, GitHubProfile, TwitterProfile, FacebookProfile
                    FROM PortfolioInfo";
                
                DataTable dt = DatabaseHelper.ExecuteQuery(query);
                
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    
                    // Contact information
                    if (!string.IsNullOrEmpty(row["Email"].ToString()))
                    {
                        litContactEmail.Text = row["Email"].ToString();
                        divContactEmail.Visible = true;
                    }
                    
                    if (!string.IsNullOrEmpty(row["PhoneNumber"].ToString()))
                    {
                        litContactPhone.Text = row["PhoneNumber"].ToString();
                        divContactPhone.Visible = true;
                    }
                    
                    if (!string.IsNullOrEmpty(row["Address"].ToString()))
                    {
                        litContactAddress.Text = row["Address"].ToString();
                        divContactAddress.Visible = true;
                    }
                    
                    // Social links
                    if (!string.IsNullOrEmpty(row["LinkedInProfile"].ToString()))
                    {
                        lnkContactLinkedIn.NavigateUrl = row["LinkedInProfile"].ToString();
                        lnkContactLinkedIn.Visible = true;
                    }
                    
                    if (!string.IsNullOrEmpty(row["GitHubProfile"].ToString()))
                    {
                        lnkContactGitHub.NavigateUrl = row["GitHubProfile"].ToString();
                        lnkContactGitHub.Visible = true;
                    }
                    
                    if (!string.IsNullOrEmpty(row["TwitterProfile"].ToString()))
                    {
                        lnkContactTwitter.NavigateUrl = row["TwitterProfile"].ToString();
                        lnkContactTwitter.Visible = true;
                    }
                    
                    if (!string.IsNullOrEmpty(row["FacebookProfile"].ToString()))
                    {
                        lnkContactFacebook.NavigateUrl = row["FacebookProfile"].ToString();
                        lnkContactFacebook.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine($"Error loading contact info: {ex.Message}");
            }
        }

        protected async void btnSend_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    // Get client IP address
                    string ipAddress = GetClientIPAddress();
                    
                    // Insert message into database
                    string insertQuery = @"
                        INSERT INTO ContactMessages (Name, Email, Subject, Message, IPAddress, ReceivedDate)
                        VALUES (@Name, @Email, @Subject, @Message, @IPAddress, @ReceivedDate)";
                    
                    SqlParameter[] parameters = {
                        new SqlParameter("@Name", txtName.Text.Trim()),
                        new SqlParameter("@Email", txtEmail.Text.Trim()),
                        new SqlParameter("@Subject", string.IsNullOrEmpty(txtSubject.Text.Trim()) ? "Contact Form Message" : txtSubject.Text.Trim()),
                        new SqlParameter("@Message", txtMessage.Text.Trim()),
                        new SqlParameter("@IPAddress", ipAddress),
                        new SqlParameter("@ReceivedDate", DateTime.Now)
                    };
                    
                    int result = DatabaseHelper.ExecuteNonQuery(insertQuery, parameters);
                    
                    if (result > 0)
                    {
                        // Send email notification
                        bool emailSent = await EmailHelper.SendContactNotificationAsync(
                            txtName.Text.Trim(),
                            txtEmail.Text.Trim(),
                            txtMessage.Text.Trim()
                        );
                        
                        // Show success message
                        ShowMessage("Thank you for your message! I'll get back to you as soon as possible.", "success");
                        
                        // Clear form
                        ClearForm();
                        
                        if (!emailSent)
                        {
                            // Log email failure but don't show error to user
                            System.Diagnostics.Debug.WriteLine("Email notification failed to send");
                        }
                    }
                    else
                    {
                        ShowMessage("There was an error sending your message. Please try again.", "error");
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the actual error but show a generic message to the user
                System.Diagnostics.Debug.WriteLine($"Contact form error: {ex.Message}");
                ShowMessage("There was an error sending your message. Please try again later.", "error");
            }
            finally
            {
                // Reset button state
                btnSend.Text = "Send Message";
                btnSend.Enabled = true;
            }
        }

        private void ShowMessage(string message, string type)
        {
            if (type == "success")
            {
                litMessage.Text = message;
                pnlMessage.Visible = true;
                pnlError.Visible = false;
            }
            else
            {
                litError.Text = message;
                pnlError.Visible = true;
                pnlMessage.Visible = false;
            }
        }

        private void ClearForm()
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtSubject.Text = "";
            txtMessage.Text = "";
        }

        private string GetClientIPAddress()
        {
            string ipAddress = "";
            
            // Check for IP in various headers due to proxies, load balancers, etc.
            string[] headers = {
                "HTTP_X_FORWARDED_FOR",
                "HTTP_X_REAL_IP",
                "HTTP_CF_CONNECTING_IP",
                "REMOTE_ADDR"
            };
            
            foreach (string header in headers)
            {
                ipAddress = Request.ServerVariables[header];
                if (!string.IsNullOrEmpty(ipAddress) && ipAddress != "unknown")
                {
                    // X-Forwarded-For can contain multiple IPs, take the first one
                    if (ipAddress.Contains(","))
                    {
                        ipAddress = ipAddress.Split(',')[0];
                    }
                    break;
                }
            }
            
            // Fallback to UserHostAddress
            if (string.IsNullOrEmpty(ipAddress))
            {
                ipAddress = Request.UserHostAddress;
            }
            
            // Ensure we don't return null
            return ipAddress ?? "Unknown";
        }
    }
}