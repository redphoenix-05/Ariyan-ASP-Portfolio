using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class SimpleTest : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Test - Working";
            
            // Simple test to ensure page loads
            Response.Write("<!-- SimpleTest page loaded at " + DateTime.Now.ToString() + " -->");
        }
    }
}