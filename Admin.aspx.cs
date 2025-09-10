using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Admin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect to the working simple admin
            Response.Redirect("SimpleAdmin.aspx");
        }

        // Empty event handlers to satisfy the ASPX file
        protected void btnLogin_Click(object sender, EventArgs e) { }
        protected void btnLogout_Click(object sender, EventArgs e) { }
        protected void btnSkills_Click(object sender, EventArgs e) { }
        protected void btnProjects_Click(object sender, EventArgs e) { }
        protected void btnEducation_Click(object sender, EventArgs e) { }
        protected void btnAddSkill_Click(object sender, EventArgs e) { }
        protected void btnAddProject_Click(object sender, EventArgs e) { }
        protected void btnAddEducation_Click(object sender, EventArgs e) { }
        protected void gvSkills_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e) { }
        protected void gvProjects_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e) { }
        protected void gvEducation_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e) { }
    }
}