using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace WebApplication1
{
    public partial class Test : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSystemInfo();
                TestDatabaseConnection();
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

        private void TestDatabaseConnection()
        {
            try
            {
                // Test Skills
                DataTable skills = DatabaseHelper.GetSkills();
                Response.Write($"<h2>Database Connection Test</h2>");
                Response.Write($"<h3>Skills Test</h3>");
                Response.Write($"<p>Skills found: {skills.Rows.Count}</p>");
                
                if (skills.Rows.Count > 0)
                {
                    Response.Write("<ul>");
                    foreach (DataRow row in skills.Rows)
                    {
                        Response.Write($"<li>{row["SkillName"]} - Category: {row["SkillCategory"]} - Level: {row["ProficiencyLevel"]}%</li>");
                    }
                    Response.Write("</ul>");
                }

                // Test Education
                DataTable education = DatabaseHelper.GetEducation();
                Response.Write($"<h3>Education Test</h3>");
                Response.Write($"<p>Education records found: {education.Rows.Count}</p>");
                
                if (education.Rows.Count > 0)
                {
                    Response.Write("<ul>");
                    foreach (DataRow row in education.Rows)
                    {
                        Response.Write($"<li>{row["Degree"]} at {row["Institution"]} ({row["StartYear"]}-{(row["EndYear"] == DBNull.Value ? "Present" : row["EndYear"].ToString())})</li>");
                    }
                    Response.Write("</ul>");
                }

                Response.Write("<p style='color: green;'>Database connection successful!</p>");
            }
            catch (Exception ex)
            {
                Response.Write($"<p style='color: red;'>Database connection failed: {ex.Message}</p>");
                Response.Write($"<p style='color: red;'>Stack trace: {ex.StackTrace}</p>");
            }
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