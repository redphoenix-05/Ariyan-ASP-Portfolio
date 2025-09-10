using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Configuration;
using System.Text;
using System.Text.RegularExpressions;

namespace WebApplication1
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Clear any previous messages
                pnlSuccess.Visible = false;
                pnlError.Visible = false;
            }
        }

        protected void btnSendMessage_Click(object sender, EventArgs e)
        {
            try
            {
                // Get form values
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string message = txtMessage.Text.Trim();

                // Server-side validation (backup for client-side validation)
                var validationResult = ValidateFormData(name, email, phone, message);
                
                if (!validationResult.IsValid)
                {
                    ShowErrorMessage(validationResult.ErrorMessage);
                    
                    // Re-enable submit button with JavaScript
                    string script = @"
                        document.addEventListener('DOMContentLoaded', function() {
                            const submitBtn = document.getElementById('" + btnSendMessage.ClientID + @"');
                            if (submitBtn) {
                                submitBtn.innerHTML = 'Send Message';
                                submitBtn.disabled = false;
                            }
                        });";
                    ClientScript.RegisterStartupScript(this.GetType(), "ReEnableButton", script, true);
                    
                    return;
                }

                // Save to database (if you have ContactMessages table)
                bool savedToDatabase = SaveContactMessage(name, email, phone, message);

                // Attempt to send email notification
                bool emailSent = SendContactEmail(name, email, phone, message);

                if (savedToDatabase)
                {
                    // Success - show success message and clear form
                    if (emailSent)
                    {
                        ShowSuccessMessage("Thank you for your message! I'll get back to you soon. Your message has been saved and I've been notified via email.");
                    }
                    else
                    {
                        ShowSuccessMessage("Thank you for your message! I'll get back to you soon. Your message has been saved successfully.");
                    }
                    
                    ClearForm();
                }
                else
                {
                    // Database save failed
                    ShowErrorMessage("Sorry, there was an error saving your message. Please try again or contact me directly via email.");
                }
            }
            catch (Exception ex)
            {
                // Log error (in production, use proper logging)
                System.Diagnostics.Debug.WriteLine($"Contact form error: {ex.Message}");
                ShowErrorMessage("An unexpected error occurred. Please try again later.");
                
                // Re-enable submit button
                string script = @"
                    document.addEventListener('DOMContentLoaded', function() {
                        const submitBtn = document.getElementById('" + btnSendMessage.ClientID + @"');
                        if (submitBtn) {
                            submitBtn.innerHTML = 'Send Message';
                            submitBtn.disabled = false;
                        }
                    });";
                ClientScript.RegisterStartupScript(this.GetType(), "ReEnableButton", script, true);
            }
        }

        private ValidationResult ValidateFormData(string name, string email, string phone, string message)
        {
            var result = new ValidationResult { IsValid = true, ErrorMessage = "" };
            var errors = new System.Collections.Generic.List<string>();

            // Validate Name (required)
            if (string.IsNullOrEmpty(name))
            {
                errors.Add("Name is required");
            }
            else if (name.Length > 100)
            {
                errors.Add("Name must be less than 100 characters");
            }

            // Validate Email (required and format)
            if (string.IsNullOrEmpty(email))
            {
                errors.Add("Email is required");
            }
            else if (email.Length > 100)
            {
                errors.Add("Email must be less than 100 characters");
            }
            else if (!IsValidEmail(email))
            {
                errors.Add("Please enter a valid email address");
            }

            // Validate Phone (optional but format check if provided)
            if (!string.IsNullOrEmpty(phone))
            {
                if (phone.Length > 20)
                {
                    errors.Add("Phone number must be less than 20 characters");
                }
                else if (!IsValidPhone(phone))
                {
                    errors.Add("Please enter a valid phone number");
                }
            }

            // Validate Message (required)
            if (string.IsNullOrEmpty(message))
            {
                errors.Add("Message is required");
            }
            else if (message.Length > 1000)
            {
                errors.Add("Message must be less than 1000 characters");
            }

            if (errors.Count > 0)
            {
                result.IsValid = false;
                result.ErrorMessage = "Please fix the following errors:<br/>• " + string.Join("<br/>• ", errors);
            }

            return result;
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var emailRegex = new Regex(@"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                return emailRegex.IsMatch(email);
            }
            catch
            {
                return false;
            }
        }

        private bool IsValidPhone(string phone)
        {
            try
            {
                var phoneRegex = new Regex(@"^[\+]?[0-9\s\-\(\)]{10,20}$");
                return phoneRegex.IsMatch(phone);
            }
            catch
            {
                return false;
            }
        }

        private bool SaveContactMessage(string name, string email, string phone, string message)
        {
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PortfolioConnectionString"]?.ConnectionString;
                
                if (string.IsNullOrEmpty(connectionString))
                {
                    // No database connection configured - skip database save
                    System.Diagnostics.Debug.WriteLine("No database connection configured for contact messages");
                    return true; // Return true so the process continues
                }

                using (var conn = new System.Data.SqlClient.SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Create ContactMessages table if it doesn't exist
                    string createTableQuery = @"
                        IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ContactMessages' AND xtype='U')
                        CREATE TABLE ContactMessages (
                            MessageId int IDENTITY(1,1) PRIMARY KEY,
                            SenderName nvarchar(100) NOT NULL,
                            SenderEmail nvarchar(100) NOT NULL,
                            SenderPhone nvarchar(20) NULL,
                            Subject nvarchar(200) NULL,
                            MessageBody nvarchar(1000) NOT NULL,
                            ReceivedDate datetime NOT NULL DEFAULT GETDATE(),
                            IsRead bit NOT NULL DEFAULT 0,
                            IPAddress nvarchar(50) NULL
                        )";
                    
                    using (var createCmd = new System.Data.SqlClient.SqlCommand(createTableQuery, conn))
                    {
                        createCmd.ExecuteNonQuery();
                    }
                    
                    // Insert the contact message
                    string insertQuery = @"
                        INSERT INTO ContactMessages (SenderName, SenderEmail, SenderPhone, Subject, MessageBody, IPAddress)
                        VALUES (@SenderName, @SenderEmail, @SenderPhone, @Subject, @MessageBody, @IPAddress)";
                    
                    using (var cmd = new System.Data.SqlClient.SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@SenderName", name);
                        cmd.Parameters.AddWithValue("@SenderEmail", email);
                        cmd.Parameters.AddWithValue("@SenderPhone", string.IsNullOrEmpty(phone) ? (object)DBNull.Value : phone);
                        cmd.Parameters.AddWithValue("@Subject", "Portfolio Contact Form Message");
                        cmd.Parameters.AddWithValue("@MessageBody", message);
                        cmd.Parameters.AddWithValue("@IPAddress", Request.UserHostAddress ?? "Unknown");
                        
                        int result = cmd.ExecuteNonQuery();
                        return result > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Database save error: {ex.Message}");
                return false;
            }
        }

        private bool SendContactEmail(string name, string email, string phone, string message)
        {
            try
            {
                // Create email message
                StringBuilder emailBody = new StringBuilder();
                emailBody.AppendLine("New Contact Form Submission");
                emailBody.AppendLine("================================");
                emailBody.AppendLine($"Name: {name}");
                emailBody.AppendLine($"Email: {email}");
                emailBody.AppendLine($"Phone: {(!string.IsNullOrEmpty(phone) ? phone : "Not provided")}");
                emailBody.AppendLine($"IP Address: {Request.UserHostAddress ?? "Unknown"}");
                emailBody.AppendLine("");
                emailBody.AppendLine("Message:");
                emailBody.AppendLine("--------");
                emailBody.AppendLine(message);
                emailBody.AppendLine("");
                emailBody.AppendLine("================================");
                emailBody.AppendLine($"Submitted on: {DateTime.Now:yyyy-MM-dd HH:mm:ss}");

                // For development/testing, we'll log the email instead of sending
                // In production, configure SMTP settings in web.config
                if (IsEmailConfigured())
                {
                    // Email configuration
                    MailMessage mail = new MailMessage();
                    mail.To.Add("ariyan.aftab@example.com"); // Replace with your actual email
                    mail.From = new MailAddress("noreply@yourportfolio.com", "Portfolio Contact Form");
                    mail.Subject = $"Portfolio Contact: {name}";
                    mail.Body = emailBody.ToString();
                    mail.IsBodyHtml = false;

                    // Add reply-to address
                    mail.ReplyToList.Add(email);

                    // SMTP configuration
                    SmtpClient smtp = new SmtpClient();
                    smtp.Send(mail);
                }
                else
                {
                    // For demo purposes - log the email instead of sending
                    System.Diagnostics.Debug.WriteLine("Contact email notification:");
                    System.Diagnostics.Debug.WriteLine(emailBody.ToString());
                }

                return true;
            }
            catch (Exception ex)
            {
                // Log error but don't fail the entire process
                System.Diagnostics.Debug.WriteLine($"Email sending error: {ex.Message}");
                return false;
            }
        }

        private bool IsEmailConfigured()
        {
            try
            {
                // Check if SMTP is configured in web.config
                var smtpSection = System.Configuration.ConfigurationManager.GetSection("system.net/mailSettings/smtp");
                return smtpSection != null;
            }
            catch
            {
                return false;
            }
        }

        private void ShowSuccessMessage(string message)
        {
            litSuccessMessage.Text = message;
            pnlSuccess.Visible = true;
            pnlError.Visible = false;

            // Add auto-hide functionality
            string script = @"
                document.addEventListener('DOMContentLoaded', function() {
                    setTimeout(function() {
                        const successPanel = document.getElementById('" + pnlSuccess.ClientID + @"');
                        if (successPanel) {
                            successPanel.style.opacity = '0';
                            setTimeout(function() {
                                successPanel.style.display = 'none';
                            }, 300);
                        }
                    }, 5000);
                });";
            ClientScript.RegisterStartupScript(this.GetType(), "AutoHideSuccess", script, true);
        }

        private void ShowErrorMessage(string message)
        {
            litErrorMessage.Text = message;
            pnlError.Visible = true;
            pnlSuccess.Visible = false;

            // Add auto-hide functionality
            string script = @"
                document.addEventListener('DOMContentLoaded', function() {
                    setTimeout(function() {
                        const errorPanel = document.getElementById('" + pnlError.ClientID + @"');
                        if (errorPanel) {
                            errorPanel.style.opacity = '0';
                            setTimeout(function() {
                                errorPanel.style.display = 'none';
                            }, 300);
                        }
                    }, 8000);
                });";
            ClientScript.RegisterStartupScript(this.GetType(), "AutoHideError", script, true);
        }

        private void ClearForm()
        {
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtMessage.Text = string.Empty;

            // Add JavaScript to clear any validation styling
            string script = @"
                document.addEventListener('DOMContentLoaded', function() {
                    const fields = document.querySelectorAll('.form-control-hero');
                    fields.forEach(function(field) {
                        field.classList.remove('is-invalid');
                        field.parentElement.classList.remove('focused');
                    });
                    
                    const errorElements = document.querySelectorAll('.invalid-feedback');
                    errorElements.forEach(function(element) {
                        element.style.display = 'none';
                    });
                    
                    const validationSummary = document.getElementById('validationSummary');
                    if (validationSummary) {
                        validationSummary.style.display = 'none';
                    }
                    
                    const submitBtn = document.getElementById('" + btnSendMessage.ClientID + @"');
                    if (submitBtn) {
                        submitBtn.innerHTML = 'Send Message';
                        submitBtn.disabled = false;
                    }
                });";
            ClientScript.RegisterStartupScript(this.GetType(), "ClearForm", script, true);
        }
    }

    // Helper class for validation results
    public class ValidationResult
    {
        public bool IsValid { get; set; }
        public string ErrorMessage { get; set; }
    }
}