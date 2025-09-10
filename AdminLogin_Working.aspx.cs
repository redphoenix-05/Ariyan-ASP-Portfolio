using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class AdminLogin_Working : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect to the new admin system
            Response.Redirect("Admin.aspx");
        }
    }
}