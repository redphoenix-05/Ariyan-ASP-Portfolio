using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class SimpleAdminWorking : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect to the new working admin page
            Response.Redirect("WorkingAdmin.aspx");
        }
    }
}