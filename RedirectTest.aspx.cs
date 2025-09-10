using System;
using System.Web;
using System.Web.UI;

namespace WebApplication1
{
    public partial class RedirectTest : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                litSessionInfo.Text = Session.SessionID != null ? "? Available" : "? Not Available";
            }
        }

        protected void btnRedirectToAdminTest_Click(object sender, EventArgs e)
        {
            try
            {
                // Set up session data for testing
                Session["AdminLoggedIn"] = true;
                Session["AdminUsername"] = "redirect_test";
                Session["AdminUserId"] = 999;
                Session["AdminFullName"] = "Redirect Test User";
                Session["LoginTime"] = DateTime.Now;

                System.Diagnostics.Debug.WriteLine("RedirectTest: Attempting redirect to AdminTest.aspx");
                
                Response.Redirect("AdminTest.aspx", false);
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"RedirectTest error: {ex.Message}");
                Response.Write($"<script>alert('Redirect Error: {ex.Message.Replace("'", "\\'")}');</script>");
            }
        }

        protected void btnRedirectToAdmin_Click(object sender, EventArgs e)
        {
            try
            {
                // Set up session data for testing
                Session["AdminLoggedIn"] = true;
                Session["AdminUsername"] = "redirect_test";
                Session["AdminUserId"] = 999;
                Session["AdminFullName"] = "Redirect Test User";
                Session["LoginTime"] = DateTime.Now;

                System.Diagnostics.Debug.WriteLine("RedirectTest: Attempting redirect to Admin.aspx");
                
                Response.Redirect("Admin.aspx", false);
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"RedirectTest error: {ex.Message}");
                Response.Write($"<script>alert('Redirect Error: {ex.Message.Replace("'", "\\'")}');</script>");
            }
        }
    }
}