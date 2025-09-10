<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebApplication1.Admin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Portfolio Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
        }
        .admin-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            margin: 20px auto;
            max-width: 1200px;
            overflow: hidden;
        }
        .admin-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px;
            text-align: center;
        }
        .login-section {
            padding: 40px;
            text-align: center;
        }
        .admin-section {
            padding: 30px;
        }
        .crud-section {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 30px;
            overflow: hidden;
        }
        .section-header {
            background: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #dee2e6;
            font-weight: bold;
            color: #495057;
        }
        .section-content {
            padding: 20px;
        }
        .btn-admin {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
        }
        .btn-admin:hover {
            background: linear-gradient(135deg, #764ba2, #667eea);
            color: white;
        }
        .table-responsive {
            max-height: 400px;
            overflow-y: auto;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="admin-container">
                <div class="admin-header">
                    <h1><i class="fas fa-cog me-2"></i>Portfolio Admin Panel</h1>
                    <p>Simple CRUD Operations for Database Management</p>
                </div>

                <!-- Login Section -->
                <div id="loginSection" runat="server" class="login-section">
                    <h3>Admin Access</h3>
                    <p>Enter credentials to manage portfolio content</p>
                    
                    <div class="row justify-content-center">
                        <div class="col-md-4">
                            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert">
                                <asp:Literal ID="litMessage" runat="server" />
                            </asp:Panel>
                            
                            <div class="mb-3">
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username" />
                            </div>
                            <div class="mb-3">
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password" />
                            </div>
                            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-admin w-100" Text="Login" OnClick="btnLogin_Click" />
                            
                            <div class="mt-3">
                                <small class="text-muted">Default: admin / 2107045</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Admin Panel Section -->
                <div id="adminSection" runat="server" class="admin-section" style="display: none;">
                    
                    <!-- Navigation -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <nav class="nav nav-pills nav-fill">
                                <asp:LinkButton ID="btnSkills" runat="server" CssClass="nav-link active" OnClick="btnSkills_Click" Text="Skills Management" />
                                <asp:LinkButton ID="btnProjects" runat="server" CssClass="nav-link" OnClick="btnProjects_Click" Text="Projects Management" />
                                <asp:LinkButton ID="btnEducation" runat="server" CssClass="nav-link" OnClick="btnEducation_Click" Text="Education Management" />
                                <a href="Default.aspx" class="nav-link" target="_blank"><i class="fas fa-eye me-1"></i>View Site</a>
                                <asp:LinkButton ID="btnLogout" runat="server" CssClass="nav-link text-danger" OnClick="btnLogout_Click" Text="Logout" />
                            </nav>
                        </div>
                    </div>

                    <!-- Skills Management -->
                    <div id="skillsPanel" runat="server" class="crud-section">
                        <div class="section-header">
                            <i class="fas fa-cogs me-2"></i>Skills Management
                        </div>
                        <div class="section-content">
                            <div class="row">
                                <!-- Add New Skill -->
                                <div class="col-md-4">
                                    <h5>Add New Skill</h5>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtSkillName" runat="server" CssClass="form-control" placeholder="Skill Name" />
                                    </div>
                                    <div class="mb-3">
                                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                                            <asp:ListItem Text="Programming" Value="Programming" />
                                            <asp:ListItem Text="Framework" Value="Framework" />
                                            <asp:ListItem Text="Mobile" Value="Mobile" />
                                            <asp:ListItem Text="Database" Value="Database" />
                                            <asp:ListItem Text="Technology" Value="Technology" />
                                        </asp:DropDownList>
                                    </div>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtProficiency" runat="server" CssClass="form-control" placeholder="Proficiency (1-100)" TextMode="Number" />
                                    </div>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtIconClass" runat="server" CssClass="form-control" placeholder="Font Awesome Icon (e.g., fas fa-code)" />
                                    </div>
                                    <asp:Button ID="btnAddSkill" runat="server" CssClass="btn btn-admin w-100" Text="Add Skill" OnClick="btnAddSkill_Click" />
                                </div>
                                
                                <!-- Skills List -->
                                <div class="col-md-8">
                                    <h5>Current Skills</h5>
                                    <div class="table-responsive">
                                        <asp:GridView ID="gvSkills" runat="server" CssClass="table table-striped table-sm" AutoGenerateColumns="false" DataKeyNames="SkillId" OnRowDeleting="gvSkills_RowDeleting">
                                            <Columns>
                                                <asp:BoundField DataField="SkillName" HeaderText="Skill" />
                                                <asp:BoundField DataField="SkillCategory" HeaderText="Category" />
                                                <asp:BoundField DataField="ProficiencyLevel" HeaderText="Level %" />
                                                <asp:TemplateField HeaderText="Active">
                                                    <ItemTemplate>
                                                        <span class='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge bg-success" : "badge bg-secondary" %>'>
                                                            <%# Convert.ToBoolean(Eval("IsActive")) ? "Yes" : "No" %>
                                                        </span>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Actions">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-outline-danger btn-sm" CommandName="Delete" OnClientClick="return confirm('Delete this skill?')">
                                                            <i class="fas fa-trash"></i>
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <div class="text-center text-muted p-3">No skills found. Add your first skill!</div>
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Projects Management -->
                    <div id="projectsPanel" runat="server" class="crud-section" style="display: none;">
                        <div class="section-header">
                            <i class="fas fa-folder-open me-2"></i>Projects Management
                        </div>
                        <div class="section-content">
                            <div class="row">
                                <!-- Add New Project -->
                                <div class="col-md-4">
                                    <h5>Add New Project</h5>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtProjectTitle" runat="server" CssClass="form-control" placeholder="Project Title" />
                                    </div>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtProjectDesc" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Project Description" />
                                    </div>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtTechStack" runat="server" CssClass="form-control" placeholder="Tech Stack (comma separated)" />
                                    </div>
                                    <div class="mb-3">
                                        <asp:DropDownList ID="ddlProjectType" runat="server" CssClass="form-select">
                                            <asp:ListItem Text="Web" Value="Web" />
                                            <asp:ListItem Text="Mobile" Value="Mobile" />
                                            <asp:ListItem Text="Desktop" Value="Desktop" />
                                            <asp:ListItem Text="API" Value="API" />
                                            <asp:ListItem Text="ML" Value="ML" />
                                        </asp:DropDownList>
                                    </div>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtGithubLink" runat="server" CssClass="form-control" placeholder="GitHub Link (optional)" />
                                    </div>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtDemoLink" runat="server" CssClass="form-control" placeholder="Demo Link (optional)" />
                                    </div>
                                    <asp:Button ID="btnAddProject" runat="server" CssClass="btn btn-admin w-100" Text="Add Project" OnClick="btnAddProject_Click" />
                                </div>
                                
                                <!-- Projects List -->
                                <div class="col-md-8">
                                    <h5>Current Projects</h5>
                                    <div class="table-responsive">
                                        <asp:GridView ID="gvProjects" runat="server" CssClass="table table-striped table-sm" AutoGenerateColumns="false" DataKeyNames="ProjectId" OnRowDeleting="gvProjects_RowDeleting">
                                            <Columns>
                                                <asp:BoundField DataField="Title" HeaderText="Title" />
                                                <asp:BoundField DataField="ProjectType" HeaderText="Type" />
                                                <asp:BoundField DataField="Status" HeaderText="Status" />
                                                <asp:TemplateField HeaderText="Featured">
                                                    <ItemTemplate>
                                                        <span class='<%# Convert.ToBoolean(Eval("IsFeatured")) ? "badge bg-warning" : "badge bg-light text-dark" %>'>
                                                            <%# Convert.ToBoolean(Eval("IsFeatured")) ? "Yes" : "No" %>
                                                        </span>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Actions">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnDeleteProject" runat="server" CssClass="btn btn-outline-danger btn-sm" CommandName="Delete" OnClientClick="return confirm('Delete this project?')">
                                                            <i class="fas fa-trash"></i>
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <div class="text-center text-muted p-3">No projects found. Add your first project!</div>
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Education Management -->
                    <div id="educationPanel" runat="server" class="crud-section" style="display: none;">
                        <div class="section-header">
                            <i class="fas fa-graduation-cap me-2"></i>Education Management
                        </div>
                        <div class="section-content">
                            <div class="row">
                                <!-- Add New Education -->
                                <div class="col-md-4">
                                    <h5>Add New Education</h5>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtDegree" runat="server" CssClass="form-control" placeholder="Degree" />
                                    </div>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtInstitution" runat="server" CssClass="form-control" placeholder="Institution" />
                                    </div>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtStartYear" runat="server" CssClass="form-control" placeholder="Start Year" TextMode="Number" />
                                    </div>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtEndYear" runat="server" CssClass="form-control" placeholder="End Year (optional)" TextMode="Number" />
                                    </div>
                                    <div class="mb-3">
                                        <asp:TextBox ID="txtGrade" runat="server" CssClass="form-control" placeholder="Grade/GPA (optional)" />
                                    </div>
                                    <asp:Button ID="btnAddEducation" runat="server" CssClass="btn btn-admin w-100" Text="Add Education" OnClick="btnAddEducation_Click" />
                                </div>
                                
                                <!-- Education List -->
                                <div class="col-md-8">
                                    <h5>Current Education</h5>
                                    <div class="table-responsive">
                                        <asp:GridView ID="gvEducation" runat="server" CssClass="table table-striped table-sm" AutoGenerateColumns="false" DataKeyNames="EducationId" OnRowDeleting="gvEducation_RowDeleting">
                                            <Columns>
                                                <asp:BoundField DataField="Degree" HeaderText="Degree" />
                                                <asp:BoundField DataField="Institution" HeaderText="Institution" />
                                                <asp:BoundField DataField="StartYear" HeaderText="Start" />
                                                <asp:BoundField DataField="EndYear" HeaderText="End" />
                                                <asp:BoundField DataField="Grade" HeaderText="Grade" />
                                                <asp:TemplateField HeaderText="Actions">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnDeleteEducation" runat="server" CssClass="btn btn-outline-danger btn-sm" CommandName="Delete" OnClientClick="return confirm('Delete this education record?')">
                                                            <i class="fas fa-trash"></i>
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <div class="text-center text-muted p-3">No education records found. Add your first education!</div>
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Status Messages -->
                    <div class="row">
                        <div class="col-12">
                            <asp:Panel ID="pnlStatus" runat="server" Visible="false" CssClass="alert">
                                <asp:Literal ID="litStatus" runat="server" />
                            </asp:Panel>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>