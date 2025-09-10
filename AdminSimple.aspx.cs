using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class AdminSimple : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserInfo();
                LoadSkills();
                LoadProjects();
                LoadAchievements();
            }
        }

        private void LoadUserInfo()
        {
            // Check if user is authenticated
            bool isAuthenticated = Session["AdminLoggedIn"] != null && Convert.ToBoolean(Session["AdminLoggedIn"]);
            
            if (isAuthenticated)
            {
                string username = Session["AdminUsername"]?.ToString() ?? "Admin";
                string fullName = Session["AdminFullName"]?.ToString() ?? username;
                DateTime loginTime = Session["LoginTime"] != null ? Convert.ToDateTime(Session["LoginTime"]) : DateTime.Now;
                
                litUsername.Text = fullName;
                litUserDisplay.Text = username;
                litLoginTime.Text = loginTime.ToString("MMM dd, yyyy 'at' hh:mm tt");
                
                // Truncate session ID for better display
                string sessionId = Session.SessionID ?? "N/A";
                litSessionId.Text = sessionId.Length > 8 ? sessionId.Substring(0, 8) + "..." : sessionId;
            }
            else
            {
                litUsername.Text = "Guest User";
                litUserDisplay.Text = "Please login first";
                litLoginTime.Text = "Not authenticated";
                litSessionId.Text = "No active session";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session data
            Session.Clear();
            Session.Abandon();
            
            // Redirect to login page
            Response.Redirect("AdminLogin.aspx");
        }

        #region Skills CRUD Operations

        private void LoadSkills()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Create table if it doesn't exist
                    CreateSkillsTableIfNotExists(conn);
                    
                    string query = "SELECT SkillId, SkillName, SkillCategory, ProficiencyLevel, IconClass, Description FROM Skills WHERE IsActive = 1 ORDER BY SkillName";
                    using (SqlDataAdapter adapter = new SqlDataAdapter(query, conn))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        gvSkills.DataSource = dt;
                        gvSkills.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading skills: {ex.Message}", "danger");
            }
        }

        protected void btnAddSkill_Click(object sender, EventArgs e)
        {
            try
            {
                string skillName = txtSkillName.Text.Trim();
                string category = ddlSkillCategory.SelectedValue;
                string proficiencyText = txtProficiency.Text.Trim();
                string iconClass = txtIconClass.Text.Trim();
                string description = txtSkillDescription.Text.Trim();

                if (string.IsNullOrEmpty(skillName) || string.IsNullOrEmpty(category) || string.IsNullOrEmpty(proficiencyText))
                {
                    ShowMessage("Please fill in all required fields (Skill Name, Category, Proficiency).", "warning");
                    return;
                }

                int proficiency = 50;
                if (!int.TryParse(proficiencyText, out proficiency) || proficiency < 1 || proficiency > 100)
                {
                    ShowMessage("Proficiency must be a number between 1 and 100.", "warning");
                    return;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    CreateSkillsTableIfNotExists(conn);

                    string insertQuery = @"
                        INSERT INTO Skills (SkillName, SkillCategory, ProficiencyLevel, IconClass, Description, DisplayOrder, IsActive) 
                        VALUES (@SkillName, @SkillCategory, @ProficiencyLevel, @IconClass, @Description, 
                               (SELECT ISNULL(MAX(DisplayOrder), 0) + 1 FROM Skills), 1)";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@SkillName", skillName);
                        cmd.Parameters.AddWithValue("@SkillCategory", category);
                        cmd.Parameters.AddWithValue("@ProficiencyLevel", proficiency);
                        cmd.Parameters.AddWithValue("@IconClass", string.IsNullOrEmpty(iconClass) ? "fas fa-code" : iconClass);
                        cmd.Parameters.AddWithValue("@Description", description);

                        cmd.ExecuteNonQuery();
                    }
                }

                // Clear form and reload
                ClearSkillForm();
                LoadSkills();
                ShowMessage("Skill added successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error adding skill: {ex.Message}", "danger");
            }
        }

        protected void gvSkills_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int skillId = Convert.ToInt32(gvSkills.DataKeys[e.RowIndex].Value);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string deleteQuery = "DELETE FROM Skills WHERE SkillId = @SkillId";

                    using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@SkillId", skillId);
                        cmd.ExecuteNonQuery();
                    }
                }

                LoadSkills();
                ShowMessage("Skill deleted successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error deleting skill: {ex.Message}", "danger");
            }
        }

        protected void gvSkills_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Handle row commands if needed
        }

        protected void gvSkills_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSkills.EditIndex = e.NewEditIndex;
            LoadSkills();
        }

        protected void gvSkills_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSkills.EditIndex = -1;
            LoadSkills();
        }

        protected void gvSkills_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Implementation for updating skills - can be added if needed
            gvSkills.EditIndex = -1;
            LoadSkills();
        }

        protected void btnRefreshSkills_Click(object sender, EventArgs e)
        {
            LoadSkills();
            ShowMessage("Skills refreshed successfully!", "info");
        }

        private void ClearSkillForm()
        {
            txtSkillName.Text = "";
            ddlSkillCategory.SelectedIndex = 0;
            txtProficiency.Text = "";
            txtIconClass.Text = "";
            txtSkillDescription.Text = "";
        }

        private void CreateSkillsTableIfNotExists(SqlConnection conn)
        {
            string createTableQuery = @"
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Skills' AND xtype='U')
                CREATE TABLE Skills (
                    SkillId int IDENTITY(1,1) PRIMARY KEY,
                    SkillName nvarchar(100) NOT NULL,
                    SkillCategory nvarchar(50) NOT NULL,
                    ProficiencyLevel int NOT NULL DEFAULT 50,
                    IconClass nvarchar(50) NULL,
                    Description nvarchar(500) NULL,
                    DisplayOrder int NOT NULL DEFAULT 0,
                    IsActive bit NOT NULL DEFAULT 1,
                    CreatedDate datetime NOT NULL DEFAULT GETDATE()
                )";

            using (SqlCommand cmd = new SqlCommand(createTableQuery, conn))
            {
                cmd.ExecuteNonQuery();
            }
        }

        #endregion

        #region Projects CRUD Operations

        private void LoadProjects()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Create table if it doesn't exist
                    CreateProjectsTableIfNotExists(conn);
                    
                    string query = "SELECT ProjectId, Title, Description, TechStack, ProjectType, Status, GitHubLink, DemoLink FROM Projects WHERE IsActive = 1 ORDER BY Title";
                    using (SqlDataAdapter adapter = new SqlDataAdapter(query, conn))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        gvProjects.DataSource = dt;
                        gvProjects.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading projects: {ex.Message}", "danger");
            }
        }

        protected void btnAddProject_Click(object sender, EventArgs e)
        {
            try
            {
                string title = txtProjectTitle.Text.Trim();
                string projectType = ddlProjectType.SelectedValue;
                string techStack = txtTechStack.Text.Trim();
                string description = txtProjectDescription.Text.Trim();
                string githubLink = txtGitHubLink.Text.Trim();
                string demoLink = txtDemoLink.Text.Trim();

                if (string.IsNullOrEmpty(title))
                {
                    ShowMessage("Please enter a project title.", "warning");
                    return;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    CreateProjectsTableIfNotExists(conn);

                    string insertQuery = @"
                        INSERT INTO Projects (Title, Description, TechStack, GitHubLink, DemoLink, ProjectType, Status, DisplayOrder, IsActive) 
                        VALUES (@Title, @Description, @TechStack, @GitHubLink, @DemoLink, @ProjectType, @Status, 
                               (SELECT ISNULL(MAX(DisplayOrder), 0) + 1 FROM Projects), 1)";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@TechStack", techStack);
                        cmd.Parameters.AddWithValue("@GitHubLink", string.IsNullOrEmpty(githubLink) ? "#" : githubLink);
                        cmd.Parameters.AddWithValue("@DemoLink", string.IsNullOrEmpty(demoLink) ? "#" : demoLink);
                        cmd.Parameters.AddWithValue("@ProjectType", string.IsNullOrEmpty(projectType) ? "Web" : projectType);
                        cmd.Parameters.AddWithValue("@Status", "Active");

                        cmd.ExecuteNonQuery();
                    }
                }

                ClearProjectForm();
                LoadProjects();
                ShowMessage("Project added successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error adding project: {ex.Message}", "danger");
            }
        }

        protected void gvProjects_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int projectId = Convert.ToInt32(gvProjects.DataKeys[e.RowIndex].Value);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string deleteQuery = "DELETE FROM Projects WHERE ProjectId = @ProjectId";

                    using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ProjectId", projectId);
                        cmd.ExecuteNonQuery();
                    }
                }

                LoadProjects();
                ShowMessage("Project deleted successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error deleting project: {ex.Message}", "danger");
            }
        }

        protected void btnRefreshProjects_Click(object sender, EventArgs e)
        {
            LoadProjects();
            ShowMessage("Projects refreshed successfully!", "info");
        }

        private void ClearProjectForm()
        {
            txtProjectTitle.Text = "";
            ddlProjectType.SelectedIndex = 0;
            txtTechStack.Text = "";
            txtProjectDescription.Text = "";
            txtGitHubLink.Text = "";
            txtDemoLink.Text = "";
        }

        private void CreateProjectsTableIfNotExists(SqlConnection conn)
        {
            string createTableQuery = @"
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Projects' AND xtype='U')
                CREATE TABLE Projects (
                    ProjectId int IDENTITY(1,1) PRIMARY KEY,
                    Title nvarchar(200) NOT NULL,
                    Description nvarchar(1000) NULL,
                    TechStack nvarchar(500) NULL,
                    GitHubLink nvarchar(500) NULL,
                    DemoLink nvarchar(500) NULL,
                    ImagePath nvarchar(500) NULL,
                    ProjectType nvarchar(50) NOT NULL DEFAULT 'Web',
                    Status nvarchar(50) NOT NULL DEFAULT 'Active',
                    DisplayOrder int NOT NULL DEFAULT 0,
                    IsFeatured bit NOT NULL DEFAULT 0,
                    IsActive bit NOT NULL DEFAULT 1,
                    CreatedDate datetime NOT NULL DEFAULT GETDATE()
                )";

            using (SqlCommand cmd = new SqlCommand(createTableQuery, conn))
            {
                cmd.ExecuteNonQuery();
            }
        }

        #endregion

        #region Achievements CRUD Operations

        private void LoadAchievements()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Create table if it doesn't exist
                    CreateAchievementsTableIfNotExists(conn);
                    
                    string query = "SELECT AchievementId, Title, Description, Organization, Category, AchievementDate FROM Achievements WHERE IsActive = 1 ORDER BY AchievementDate DESC";
                    using (SqlDataAdapter adapter = new SqlDataAdapter(query, conn))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        gvAchievements.DataSource = dt;
                        gvAchievements.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading achievements: {ex.Message}", "danger");
            }
        }

        protected void btnAddAchievement_Click(object sender, EventArgs e)
        {
            try
            {
                string title = txtAchievementTitle.Text.Trim();
                string organization = txtOrganization.Text.Trim();
                string category = txtAchievementCategory.Text.Trim();
                string dateText = txtAchievementDate.Text.Trim();
                string description = txtAchievementDescription.Text.Trim();

                if (string.IsNullOrEmpty(title))
                {
                    ShowMessage("Please enter an achievement title.", "warning");
                    return;
                }

                DateTime achievementDate = DateTime.Now;
                if (!string.IsNullOrEmpty(dateText))
                {
                    DateTime.TryParse(dateText, out achievementDate);
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    CreateAchievementsTableIfNotExists(conn);

                    string insertQuery = @"
                        INSERT INTO Achievements (Title, Description, AchievementDate, Organization, Category, IsActive) 
                        VALUES (@Title, @Description, @AchievementDate, @Organization, @Category, 1)";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@AchievementDate", achievementDate);
                        cmd.Parameters.AddWithValue("@Organization", organization);
                        cmd.Parameters.AddWithValue("@Category", category);

                        cmd.ExecuteNonQuery();
                    }
                }

                ClearAchievementForm();
                LoadAchievements();
                ShowMessage("Achievement added successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error adding achievement: {ex.Message}", "danger");
            }
        }

        protected void gvAchievements_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int achievementId = Convert.ToInt32(gvAchievements.DataKeys[e.RowIndex].Value);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string deleteQuery = "DELETE FROM Achievements WHERE AchievementId = @AchievementId";

                    using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@AchievementId", achievementId);
                        cmd.ExecuteNonQuery();
                    }
                }

                LoadAchievements();
                ShowMessage("Achievement deleted successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error deleting achievement: {ex.Message}", "danger");
            }
        }

        protected void btnRefreshAchievements_Click(object sender, EventArgs e)
        {
            LoadAchievements();
            ShowMessage("Achievements refreshed successfully!", "info");
        }

        private void ClearAchievementForm()
        {
            txtAchievementTitle.Text = "";
            txtOrganization.Text = "";
            txtAchievementCategory.Text = "";
            txtAchievementDate.Text = "";
            txtAchievementDescription.Text = "";
        }

        private void CreateAchievementsTableIfNotExists(SqlConnection conn)
        {
            string createTableQuery = @"
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Achievements' AND xtype='U')
                CREATE TABLE Achievements (
                    AchievementId int IDENTITY(1,1) PRIMARY KEY,
                    Title nvarchar(200) NOT NULL,
                    Description nvarchar(1000) NULL,
                    AchievementDate datetime NOT NULL DEFAULT GETDATE(),
                    Organization nvarchar(200) NULL,
                    Category nvarchar(100) NULL,
                    IsActive bit NOT NULL DEFAULT 1,
                    CreatedDate datetime NOT NULL DEFAULT GETDATE()
                )";

            using (SqlCommand cmd = new SqlCommand(createTableQuery, conn))
            {
                cmd.ExecuteNonQuery();
            }
        }

        #endregion

        #region Utility Methods

        private void ShowMessage(string message, string type)
        {
            string alertClass = "";
            switch (type)
            {
                case "success": alertClass = "alert-success"; break;
                case "danger": alertClass = "alert-danger"; break;
                case "warning": alertClass = "alert-warning"; break;
                case "info": alertClass = "alert-info"; break;
                default: alertClass = "alert-info"; break;
            }

            string script = $@"
                document.addEventListener('DOMContentLoaded', function() {{
                    const alertDiv = document.createElement('div');
                    alertDiv.className = 'alert {alertClass} alert-dismissible fade show';
                    alertDiv.innerHTML = `
                        {message}
                        <button type='button' class='btn-close' data-bs-dismiss='alert'></button>
                    `;
                    
                    const container = document.querySelector('.admin-container');
                    if (container) {{
                        container.insertBefore(alertDiv, container.firstChild);
                        
                        // Auto-hide after 5 seconds
                        setTimeout(() => {{
                            alertDiv.classList.remove('show');
                            setTimeout(() => alertDiv.remove(), 150);
                        }}, 5000);
                    }}
                }});";

            ClientScript.RegisterStartupScript(this.GetType(), "ShowMessage", script, true);
        }

        #endregion
    }
}