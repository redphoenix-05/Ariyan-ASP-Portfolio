using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Configuration;
using System.Text;

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
                // Validate form inputs
                if (Page.IsValid)
                {
                    // Get form values
                    string name = txtName.Text.Trim();
                    string email = txtEmail.Text.Trim();
                    string phone = txtPhone.Text.Trim();
                    string message = txtMessage.Text.Trim();

                    // Additional validation
                    if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(message))
                    {
                        ShowErrorMessage("Please fill in all required fields.");
                        return;
                    }

                    // Attempt to send email
                    bool emailSent = SendContactEmail(name, email, phone, message);

                    if (emailSent)
                    {
                        // Success - show success message and clear form
                        ShowSuccessMessage("Thank you for your message! I'll get back to you soon.");
                        ClearForm();
                    }
                    else
                    {
                        // Email sending failed - show error message
                        ShowErrorMessage("Sorry, there was an error sending your message. Please try again or contact me directly via email.");
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error (in production, use proper logging)
                System.Diagnostics.Debug.WriteLine($"Contact form error: {ex.Message}");
                ShowErrorMessage("An unexpected error occurred. Please try again later.");
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
                emailBody.AppendLine($"Message:");
                emailBody.AppendLine(message);
                emailBody.AppendLine("================================");
                emailBody.AppendLine($"Submitted on: {DateTime.Now:yyyy-MM-dd HH:mm:ss}");

                // Email configuration (you'll need to configure these settings)
                MailMessage mail = new MailMessage();
                mail.To.Add("ariyan.aftab@example.com"); // Replace with your actual email
                mail.From = new MailAddress("noreply@yourportfolio.com", "Portfolio Contact Form");
                mail.Subject = $"New Contact Form Message from {name}";
                mail.Body = emailBody.ToString();
                mail.IsBodyHtml = false;

                // Add reply-to address
                mail.ReplyToList.Add(email);

                // SMTP configuration (configure in web.config or here)
                SmtpClient smtp = new SmtpClient();
                
                // For development/testing, we'll simulate email sending
                // In production, configure SMTP settings in web.config
                if (IsEmailConfigured())
                {
                    smtp.Send(mail);
                }
                else
                {
                    // For demo purposes - simulate successful email sending
                    // In production, you'd want to configure actual SMTP settings
                    System.Diagnostics.Debug.WriteLine("Email would be sent:");
                    System.Diagnostics.Debug.WriteLine(emailBody.ToString());
                }

                return true;
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine($"Email sending error: {ex.Message}");
                return false;
            }
        }

        private bool IsEmailConfigured()
        {
            try
            {
                // Check if SMTP is configured in web.config
                var smtpSection = ConfigurationManager.GetSection("system.net/mailSettings/smtp");
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
        }

        private void ShowErrorMessage(string message)
        {
            litErrorMessage.Text = message;
            pnlError.Visible = true;
            pnlSuccess.Visible = false;
        }

        private void ClearForm()
        {
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtMessage.Text = string.Empty;
        }
    }
}