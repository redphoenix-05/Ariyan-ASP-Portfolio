using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class AdminLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect to the working simple admin
            Response.Redirect("SimpleAdmin.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Redirect to simple admin
            Response.Redirect("SimpleAdmin.aspx");
        }

        private void ShowMessage(string message, string cssClass)
        {
            // Simple implementation without control dependencies
            ClientScript.RegisterStartupScript(this.GetType(), "showMessage", 
                $"alert('{message.Replace("'", "\\'")}');", true);
        }
    }
}