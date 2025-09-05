using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Site : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Set page title if not already set
            if (string.IsNullOrEmpty(Page.Title))
            {
                Page.Title = "Home";
            }
        }
    }
}