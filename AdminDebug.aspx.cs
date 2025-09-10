using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace WebApplication1
{
    public partial class AdminDebug : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDebugInfo();
            }
        }

        private void LoadDebugInfo()
        {
            // Test database connection
            TestDatabaseConnection();
            
            // Check AdminUsers table
            CheckAdminUsersTable();
            
            // Display session info
            DisplaySessionInfo();
            
            // Display authentication status
            DisplayAuthenticationStatus();
            
            // Display recent activity
            DisplayRecentActivity();
        }

        private void TestDatabaseConnection()
        {
            try
            {
                if (string.IsNullOrEmpty(connectionString))
                {
                    ShowOutput("litDbStatus", "<div class='alert alert-danger'><i class='fas fa-times status-bad'></i> Connection string not found in Web.config</div>");
                    return;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string output = $@"
                        <div class='alert alert-success'>
                            <i class='fas fa-check status-good'></i> Database connection successful<br/>
                            <small class='text-muted'>Server: {conn.DataSource}<br/>Database: {conn.Database}</small>
                        </div>";
                    ShowOutput("litDbStatus", output);
                }
            }
            catch (Exception ex)
            {
                string output = $@"
                    <div class='alert alert-danger'>
                        <i class='fas fa-times status-bad'></i> Database connection failed<br/>
                        <small>Error: {ex.Message}</small>
                    </div>";
                ShowOutput("litDbStatus", output);
            }
        }

        private void CheckAdminUsersTable()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Check if table exists
                    string checkTableQuery = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AdminUsers'";
                    using (SqlCommand cmd = new SqlCommand(checkTableQuery, conn))
                    {
                        int tableExists = Convert.ToInt32(cmd.ExecuteScalar());
                        
                        if (tableExists > 0)
                        {
                            // Get user count
                            string countQuery = "SELECT COUNT(*) FROM AdminUsers";
                            using (SqlCommand countCmd = new SqlCommand(countQuery, conn))
                            {
                                int userCount = Convert.ToInt32(countCmd.ExecuteScalar());
                                
                                // Get admin user details
                                string adminQuery = "SELECT Username, IsActive, CreatedDate, LastLoginDate FROM AdminUsers WHERE Username = 'admin'";
                                using (SqlCommand adminCmd = new SqlCommand(adminQuery, conn))
                                {
                                    using (SqlDataReader reader = adminCmd.ExecuteReader())
                                    {
                                        if (reader.Read())
                                        {
                                            string isActive = Convert.ToBoolean(reader["IsActive"]) ? "Active" : "Inactive";
                                            string createdDate = Convert.ToDateTime(reader["CreatedDate"]).ToString("yyyy-MM-dd HH:mm");
                                            string lastLogin = reader["LastLoginDate"] == DBNull.Value ? "Never" : Convert.ToDateTime(reader["LastLoginDate"]).ToString("yyyy-MM-dd HH:mm");
                                            
                                            string output = $@"
                                                <div class='alert alert-success'>
                                                    <i class='fas fa-check status-good'></i> AdminUsers table exists<br/>
                                                    <small class='text-muted'>
                                                        Total Users: {userCount}<br/>
                                                        Default Admin: {isActive}<br/>
                                                        Created: {createdDate}<br/>
                                                        Last Login: {lastLogin}
                                                    </small>
                                                </div>";
                                            ShowOutput("litTableStatus", output);
                                        }
                                        else
                                        {
                                            string output = $@"
                                                <div class='alert alert-warning'>
                                                    <i class='fas fa-exclamation status-warning'></i> AdminUsers table exists but no default admin found<br/>
                                                    <small class='text-muted'>Total Users: {userCount}</small>
                                                </div>";
                                            ShowOutput("litTableStatus", output);
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            ShowOutput("litTableStatus", @"
                                <div class='alert alert-warning'>
                                    <i class='fas fa-exclamation status-warning'></i> AdminUsers table does not exist
                                </div>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                string output = $@"
                    <div class='alert alert-danger'>
                        <i class='fas fa-times status-bad'></i> Error checking AdminUsers table<br/>
                        <small>Error: {ex.Message}</small>
                    </div>";
                ShowOutput("litTableStatus", output);
            }
        }

        private void DisplaySessionInfo()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='code-block'>");
            
            sb.AppendFormat("Session ID: {0}<br/>", Session.SessionID);
            sb.AppendFormat("AdminLoggedIn: {0}<br/>", Session["AdminLoggedIn"] ?? "null");
            sb.AppendFormat("AdminUsername: {0}<br/>", Session["AdminUsername"] ?? "null");
            sb.AppendFormat("AdminUserId: {0}<br/>", Session["AdminUserId"] ?? "null");
            sb.AppendFormat("AdminFullName: {0}<br/>", Session["AdminFullName"] ?? "null");
            sb.AppendFormat("LoginTime: {0}<br/>", Session["LoginTime"] ?? "null");
            sb.AppendFormat("Session Timeout: {0} minutes<br/>", Session.Timeout);
            
            sb.Append("</div>");
            ShowOutput("litSessionInfo", sb.ToString());
        }

        private void DisplayAuthenticationStatus()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='code-block'>");
            
            sb.AppendFormat("User.Identity.IsAuthenticated: {0}<br/>", User.Identity.IsAuthenticated);
            sb.AppendFormat("User.Identity.Name: {0}<br/>", User.Identity.Name ?? "null");
            sb.AppendFormat("User.Identity.AuthenticationType: {0}<br/>", User.Identity.AuthenticationType ?? "null");
            
            bool sessionValid = Session["AdminLoggedIn"] != null && Convert.ToBoolean(Session["AdminLoggedIn"]);
            sb.AppendFormat("Session Valid: {0}<br/>", sessionValid);
            
            bool overallAuth = User.Identity.IsAuthenticated && sessionValid;
            sb.AppendFormat("Overall Authentication: {0}<br/>", overallAuth ? "VALID" : "INVALID");
            
            sb.Append("</div>");
            
            string alertClass = overallAuth ? "alert-success" : "alert-danger";
            string icon = overallAuth ? "fas fa-check status-good" : "fas fa-times status-bad";
            
            ShowOutput("litAuthStatus", $"<div class='alert {alertClass}'><i class='{icon}'></i> Authentication Status<br/>{sb}</div>");
        }

        private void DisplayRecentActivity()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT TOP 5 Username, LastLoginDate, FailedLoginAttempts, IsActive 
                        FROM AdminUsers 
                        ORDER BY LastLoginDate DESC";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            StringBuilder sb = new StringBuilder();
                            sb.Append("<div class='table-responsive'><table class='table table-sm'>");
                            sb.Append("<tr><th>Username</th><th>Last Login</th><th>Failed Attempts</th><th>Status</th></tr>");
                            
                            while (reader.Read())
                            {
                                string username = reader["Username"].ToString();
                                string lastLogin = reader["LastLoginDate"] == DBNull.Value ? "Never" : Convert.ToDateTime(reader["LastLoginDate"]).ToString("yyyy-MM-dd HH:mm");
                                int failedAttempts = Convert.ToInt32(reader["FailedLoginAttempts"]);
                                string status = Convert.ToBoolean(reader["IsActive"]) ? "Active" : "Inactive";
                                
                                sb.AppendFormat("<tr><td>{0}</td><td>{1}</td><td>{2}</td><td>{3}</td></tr>", 
                                    username, lastLogin, failedAttempts, status);
                            }
                            
                            sb.Append("</table></div>");
                            ShowOutput("litRecentActivity", sb.ToString());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowOutput("litRecentActivity", $"<div class='alert alert-warning'>Error loading activity: {ex.Message}</div>");
            }
        }

        protected void btnTestLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string username = Request.Form["testUsername"] ?? "admin";
                string password = Request.Form["testPassword"] ?? "admin123";
                
                var result = TestAuthentication(username, password);
                
                if (result.Success)
                {
                    ShowOutput("litLoginTest", $@"
                        <div class='alert alert-success mt-2'>
                            <i class='fas fa-check status-good'></i> Authentication successful!<br/>
                            <small>User ID: {result.UserId}, Full Name: {result.FullName}</small>
                        </div>");
                }
                else
                {
                    ShowOutput("litLoginTest", $@"
                        <div class='alert alert-danger mt-2'>
                            <i class='fas fa-times status-bad'></i> Authentication failed<br/>
                            <small>Error: {result.ErrorMessage}</small>
                        </div>");
                }
            }
            catch (Exception ex)
            {
                ShowOutput("litLoginTest", $@"
                    <div class='alert alert-danger mt-2'>
                        <i class='fas fa-times status-bad'></i> Test error: {ex.Message}
                    </div>");
            }
        }

        protected void btnCreateAdmin_Click(object sender, EventArgs e)
        {
            try
            {
                CreateDefaultAdmin();
                LoadDebugInfo(); // Refresh the display
            }
            catch (Exception ex)
            {
                ShowOutput("litLoginTest", $@"
                    <div class='alert alert-danger mt-2'>
                        <i class='fas fa-times status-bad'></i> Error creating admin: {ex.Message}
                    </div>");
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadDebugInfo();
        }

        private void ShowOutput(string elementId, string content)
        {
            string script = $@"
                document.addEventListener('DOMContentLoaded', function() {{
                    let element = document.getElementById('{elementId}');
                    if (element) {{
                        element.innerHTML = `{content.Replace("`", "\\`").Replace("'", "\\'")}`;
                    }}
                }});";
            
            ClientScript.RegisterStartupScript(this.GetType(), elementId, script, true);
        }

        private TestResult TestAuthentication(string username, string password)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    string query = "SELECT AdminId, PasswordHash, Salt, IsActive, FullName FROM AdminUsers WHERE Username = @Username";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                bool isActive = Convert.ToBoolean(reader["IsActive"]);
                                if (!isActive)
                                {
                                    return new TestResult { Success = false, ErrorMessage = "Account is inactive" };
                                }
                                
                                string storedHash = reader["PasswordHash"].ToString();
                                string salt = reader["Salt"].ToString();
                                string passwordHash = HashPassword(password, salt);
                                
                                if (passwordHash == storedHash)
                                {
                                    return new TestResult 
                                    { 
                                        Success = true, 
                                        UserId = Convert.ToInt32(reader["AdminId"]),
                                        FullName = reader["FullName"]?.ToString() ?? username
                                    };
                                }
                                else
                                {
                                    return new TestResult { Success = false, ErrorMessage = "Invalid password" };
                                }
                            }
                            else
                            {
                                return new TestResult { Success = false, ErrorMessage = "User not found" };
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new TestResult { Success = false, ErrorMessage = ex.Message };
            }
        }

        private void CreateDefaultAdmin()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                
                // Create table if it doesn't exist
                string createTableQuery = @"
                    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AdminUsers' AND xtype='U')
                    CREATE TABLE AdminUsers (
                        AdminId int IDENTITY(1,1) PRIMARY KEY,
                        Username nvarchar(50) NOT NULL UNIQUE,
                        PasswordHash nvarchar(255) NOT NULL,
                        Salt nvarchar(50) NOT NULL,
                        Email nvarchar(100) NULL,
                        FullName nvarchar(100) NULL,
                        IsActive bit NOT NULL DEFAULT 1,
                        CreatedDate datetime NOT NULL DEFAULT GETDATE(),
                        LastLoginDate datetime NULL,
                        FailedLoginAttempts int NOT NULL DEFAULT 0,
                        LastFailedLogin datetime NULL
                    )";
                
                using (SqlCommand cmd = new SqlCommand(createTableQuery, conn))
                {
                    cmd.ExecuteNonQuery();
                }
                
                // Check if admin exists
                string checkQuery = "SELECT COUNT(*) FROM AdminUsers WHERE Username = 'admin'";
                using (SqlCommand cmd = new SqlCommand(checkQuery, conn))
                {
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    
                    if (count == 0)
                    {
                        // Create admin user
                        string salt = GenerateSalt();
                        string passwordHash = HashPassword("admin123", salt);
                        
                        string insertQuery = @"
                            INSERT INTO AdminUsers (Username, PasswordHash, Salt, Email, FullName, IsActive)
                            VALUES ('admin', @PasswordHash, @Salt, 'admin@portfolio.local', 'Portfolio Administrator', 1)";
                        
                        using (SqlCommand cmd2 = new SqlCommand(insertQuery, conn))
                        {
                            cmd2.Parameters.AddWithValue("@PasswordHash", passwordHash);
                            cmd2.Parameters.AddWithValue("@Salt", salt);
                            cmd2.ExecuteNonQuery();
                        }
                        
                        ShowOutput("litLoginTest", @"
                            <div class='alert alert-success mt-2'>
                                <i class='fas fa-check status-good'></i> Default admin user created successfully!<br/>
                                <small>Username: admin, Password: admin123</small>
                            </div>");
                    }
                    else
                    {
                        ShowOutput("litLoginTest", @"
                            <div class='alert alert-info mt-2'>
                                <i class='fas fa-info status-warning'></i> Default admin user already exists
                            </div>");
                    }
                }
            }
        }

        private string GenerateSalt()
        {
            byte[] saltBytes = new byte[32];
            using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(saltBytes);
            }
            return Convert.ToBase64String(saltBytes);
        }

        private string HashPassword(string password, string salt)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] saltedPassword = Encoding.UTF8.GetBytes(password + salt);
                byte[] hash = sha256.ComputeHash(saltedPassword);
                return Convert.ToBase64String(hash);
            }
        }

        private class TestResult
        {
            public bool Success { get; set; }
            public int UserId { get; set; }
            public string FullName { get; set; }
            public string ErrorMessage { get; set; }
        }
    }
}