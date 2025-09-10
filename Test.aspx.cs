using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Test : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["PortfolioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSystemInfo();
                TestDatabaseConnections();
            }
        }

        private void LoadSystemInfo()
        {
            try
            {
                // Find controls and populate with system information
                Literal litCurrentTime = (Literal)FindControl("litCurrentTime");
                Literal litAppPath = (Literal)FindControl("litAppPath");
                Literal litServerName = (Literal)FindControl("litServerName");
                Literal litFramework = (Literal)FindControl("litFramework");

                if (litCurrentTime != null)
                    litCurrentTime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                if (litAppPath != null)
                    litAppPath.Text = Request.ApplicationPath;

                if (litServerName != null)
                    litServerName.Text = Request.ServerVariables["SERVER_NAME"];

                if (litFramework != null)
                    litFramework.Text = Environment.Version.ToString();
            }
            catch (Exception ex)
            {
                // If controls don't exist, create a simple message
                Response.Write($"<div style='color: red;'>Error loading system info: {ex.Message}</div>");
            }
        }

        private void TestDatabaseConnections()
        {
            try
            {
                // Test basic connection
                TestConnection();
                
                // Test data retrieval
                TestDataRetrieval();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in Test page: {ex.Message}");
                ShowConnectionError(ex.Message);
            }
        }

        private void TestConnection()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string version = connection.ServerVersion;
                    ShowConnectionSuccess($"Database connected successfully! Server Version: {version}");
                }
            }
            catch (Exception ex)
            {
                ShowConnectionError($"Connection failed: {ex.Message}");
            }
        }

        private void TestDataRetrieval()
        {
            try
            {
                DataTable stats = GetDatabaseStats();
                if (stats.Rows.Count > 0)
                {
                    DataRow row = stats.Rows[0];
                    ShowDataStats(row);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error retrieving data: {ex.Message}");
            }
        }

        private DataTable GetDatabaseStats()
        {
            string query = @"
                SELECT 
                    (SELECT COUNT(*) FROM Skills WHERE IsActive = 1) as TotalSkills,
                    (SELECT COUNT(*) FROM Projects WHERE IsActive = 1) as TotalProjects,
                    (SELECT COUNT(*) FROM Education WHERE IsActive = 1) as TotalEducation,
                    (SELECT COUNT(*) FROM Achievements WHERE IsActive = 1) as TotalAchievements";
            
            DataTable dataTable = new DataTable();
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            adapter.Fill(dataTable);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Database query error: {ex.Message}");
            }
            return dataTable;
        }

        private void ShowConnectionSuccess(string message)
        {
            string successScript = $@"
                document.addEventListener('DOMContentLoaded', function() {{
                    const statusDiv = document.getElementById('connectionStatus');
                    if (statusDiv) {{
                        statusDiv.innerHTML = `
                            <div class='alert alert-success'>
                                <i class='fas fa-check-circle me-2'></i>
                                <strong>Success:</strong> {message.Replace("'", "\\'")}
                            </div>
                        `;
                    }}
                }});";
            
            ClientScript.RegisterStartupScript(this.GetType(), "ConnectionSuccess", successScript, true);
        }

        private void ShowConnectionError(string error)
        {
            string errorScript = $@"
                document.addEventListener('DOMContentLoaded', function() {{
                    const statusDiv = document.getElementById('connectionStatus');
                    if (statusDiv) {{
                        statusDiv.innerHTML = `
                            <div class='alert alert-danger'>
                                <i class='fas fa-exclamation-triangle me-2'></i>
                                <strong>Error:</strong> {error.Replace("'", "\\'")}
                            </div>
                        `;
                    }}
                }});";
            
            ClientScript.RegisterStartupScript(this.GetType(), "ConnectionError", errorScript, true);
        }

        private void ShowDataStats(DataRow statsRow)
        {
            int skills = Convert.ToInt32(statsRow["TotalSkills"]);
            int projects = Convert.ToInt32(statsRow["TotalProjects"]);
            int education = Convert.ToInt32(statsRow["TotalEducation"]);
            int achievements = Convert.ToInt32(statsRow["TotalAchievements"]);

            string statsScript = $@"
                document.addEventListener('DOMContentLoaded', function() {{
                    const statsDiv = document.getElementById('dataStats');
                    if (statsDiv) {{
                        statsDiv.innerHTML = `
                            <div class='row'>
                                <div class='col-md-3'>
                                    <div class='card text-center bg-primary text-white'>
                                        <div class='card-body'>
                                            <h3>{skills}</h3>
                                            <p>Skills</p>
                                        </div>
                                    </div>
                                </div>
                                <div class='col-md-3'>
                                    <div class='card text-center bg-success text-white'>
                                        <div class='card-body'>
                                            <h3>{projects}</h3>
                                            <p>Projects</p>
                                        </div>
                                    </div>
                                </div>
                                <div class='col-md-3'>
                                    <div class='card text-center bg-info text-white'>
                                        <div class='card-body'>
                                            <h3>{education}</h3>
                                            <p>Education</p>
                                        </div>
                                    </div>
                                </div>
                                <div class='col-md-3'>
                                    <div class='card text-center bg-warning text-white'>
                                        <div class='card-body'>
                                            <h3>{achievements}</h3>
                                            <p>Achievements</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        `;
                    }}
                }});";
            
            ClientScript.RegisterStartupScript(this.GetType(), "DataStats", statsScript, true);
        }

        protected void btnTestDefault_Click(object sender, EventArgs e)
        {
            try
            {
                Panel pnlTestResult = (Panel)FindControl("pnlTestResult");
                Literal litTestResult = (Literal)FindControl("litTestResult");

                if (pnlTestResult != null && litTestResult != null)
                {
                    // Check if Default.aspx exists
                    string defaultPath = Server.MapPath("~/Default.aspx");
                    bool defaultExists = File.Exists(defaultPath);

                    if (defaultExists)
                    {
                        litTestResult.Text = "? Default.aspx file exists. Try navigating to: " +
                                           $"<a href='Default.aspx' target='_blank'>{Request.Url.GetLeftPart(UriPartial.Authority)}{Request.ApplicationPath}/Default.aspx</a>";
                        pnlTestResult.CssClass = "status success";
                    }
                    else
                    {
                        litTestResult.Text = "? Default.aspx file not found at: " + defaultPath;
                        pnlTestResult.CssClass = "status error";
                    }

                    pnlTestResult.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<div style='color: red;'>Error testing Default.aspx: {ex.Message}</div>");
            }
        }

        protected void btnTest_Click(object sender, EventArgs e)
        {
            // Legacy method for backward compatibility
            Literal litTime = (Literal)FindControl("litTime");
            Panel pnlResult = (Panel)FindControl("pnlResult");
            
            if (litTime != null)
                litTime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            
            if (pnlResult != null)
                pnlResult.Visible = true;
        }
    }
}