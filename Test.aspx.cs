using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Test : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label lblMessage = (Label)FindControl("lblMessage");
                if (lblMessage != null)
                {
                    lblMessage.Text = $"Page loaded successfully at {DateTime.Now:yyyy-MM-dd HH:mm:ss}";
                }
            }
        }

        protected void btnTest_Click(object sender, EventArgs e)
        {
            Literal litTime = (Literal)FindControl("litTime");
            Panel pnlResult = (Panel)FindControl("pnlResult");
            
            if (litTime != null)
                litTime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            
            if (pnlResult != null)
                pnlResult.Visible = true;
        }
    }
}