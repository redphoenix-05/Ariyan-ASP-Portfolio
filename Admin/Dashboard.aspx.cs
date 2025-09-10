using System;
using System.Web.UI;

namespace WebApplication1.Admin
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check authentication
            if (Session["AdminLoggedIn"] == null)
            {
                Response.Redirect("~/AdminLogin.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/AdminLogin.aspx");
        }
    }
}