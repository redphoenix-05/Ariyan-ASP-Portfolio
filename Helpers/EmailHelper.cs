using System;
using System.Configuration;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace WebApplication1
{
    public static class EmailHelper
    {
        private static readonly string smtpServer = ConfigurationManager.AppSettings["SmtpServer"];
        private static readonly int smtpPort = int.Parse(ConfigurationManager.AppSettings["SmtpPort"] ?? "587");
        private static readonly string smtpUsername = ConfigurationManager.AppSettings["SmtpUsername"];
        private static readonly string smtpPassword = ConfigurationManager.AppSettings["SmtpPassword"];
        private static readonly string fromEmail = ConfigurationManager.AppSettings["FromEmail"];

        public static async Task<bool> SendEmailAsync(string toEmail, string subject, string body, bool isHtml = true)
        {
            try
            {
                using (var client = new SmtpClient(smtpServer, smtpPort))
                {
                    client.EnableSsl = true;
                    client.UseDefaultCredentials = false;
                    client.Credentials = new NetworkCredential(smtpUsername, smtpPassword);

                    using (var message = new MailMessage())
                    {
                        message.From = new MailAddress(fromEmail);
                        message.To.Add(toEmail);
                        message.Subject = subject;
                        message.Body = body;
                        message.IsBodyHtml = isHtml;

                        await client.SendMailAsync(message);
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                // Log the error (you can implement logging here)
                System.Diagnostics.Debug.WriteLine($"Email sending failed: {ex.Message}");
                return false;
            }
        }

        public static async Task<bool> SendContactNotificationAsync(string contactName, string contactEmail, string contactMessage)
        {
            string subject = $"New Contact Message from {contactName}";
            string body = $@"
                <html>
                <body>
                    <h3>New Contact Message Received</h3>
                    <p><strong>Name:</strong> {contactName}</p>
                    <p><strong>Email:</strong> {contactEmail}</p>
                    <p><strong>Time:</strong> {DateTime.Now:yyyy-MM-dd HH:mm:ss}</p>
                    <hr>
                    <p><strong>Message:</strong></p>
                    <p>{contactMessage.Replace("\n", "<br>")}</p>
                </body>
                </html>";

            string toEmail = ConfigurationManager.AppSettings["ToEmail"];
            return await SendEmailAsync(toEmail, subject, body);
        }

        public static async Task<bool> SendReplyEmailAsync(string toEmail, string subject, string body)
        {
            return await SendEmailAsync(toEmail, subject, body);
        }
    }
}