<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminSimple.aspx.cs" Inherits="WebApplication1.AdminSimple" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Portfolio Admin Panel | Ariyan Aftab Spandan</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #14B8A6 0%, #0EA5E9 50%, #8B5CF6 100%);
            --secondary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --card-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            --border-radius: 16px;
            --text-gradient: linear-gradient(135deg, #14B8A6, #0EA5E9);
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        /* Navbar Styling */
        .admin-navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(20, 184, 166, 0.1);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            background: var(--text-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .navbar-nav .nav-link {
            color: #64748b !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .navbar-nav .nav-link:hover,
        .navbar-nav .nav-link.active {
            background: linear-gradient(135deg, #14B8A6, #0EA5E9);
            color: white !important;
            transform: translateY(-2px);
        }

        /* Main Container */
        .admin-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Hero Section */
        .admin-hero {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 3rem;
            margin-bottom: 2rem;
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
        }

        .admin-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .admin-hero h1 {
            background: var(--text-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 800;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }

        .admin-hero p {
            color: #64748b;
            font-size: 1.2rem;
            margin-bottom: 0;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--card-shadow);
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--primary-gradient);
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            background: var(--text-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
            display: block;
        }

        .stat-label {
            color: #64748b;
            font-weight: 600;
            font-size: 1rem;
        }

        .stat-icon {
            font-size: 2rem;
            margin-bottom: 1rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* Management Cards */
        .management-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .management-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .management-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }

        .management-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--primary-gradient);
        }

        .management-card h5 {
            color: #1e293b;
            font-weight: 700;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .management-card h5 i {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .management-card p {
            color: #64748b;
            margin-bottom: 1.5rem;
        }

        /* Buttons */
        .btn-custom {
            background: var(--primary-gradient);
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(20, 184, 166, 0.4);
            color: white;
        }

        .btn-outline-custom {
            border: 2px solid transparent;
            background: linear-gradient(white, white) padding-box,
                        var(--primary-gradient) border-box;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            background: var(--text-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-outline-custom:hover {
            background: var(--primary-gradient);
            -webkit-background-clip: unset;
            -webkit-text-fill-color: white;
            color: white;
            transform: translateY(-2px);
        }

        /* System Status */
        .status-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1rem;
        }

        .status-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem;
            background: rgba(20, 184, 166, 0.1);
            border-radius: 12px;
            margin-bottom: 0.5rem;
        }

        .status-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: var(--primary-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .status-text {
            font-weight: 600;
            color: #1e293b;
        }

        .status-value {
            color: #64748b;
            font-size: 0.9rem;
        }

        /* Quick Actions */
        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-top: 1rem;
        }

        /* Alert Styling */
        .alert-custom {
            background: linear-gradient(135deg, rgba(20, 184, 166, 0.1), rgba(14, 165, 233, 0.1));
            border: 1px solid rgba(20, 184, 166, 0.2);
            border-radius: var(--border-radius);
            color: #1e293b;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .admin-container {
                padding: 1rem;
            }

            .admin-hero {
                padding: 2rem;
            }

            .admin-hero h1 {
                font-size: 2rem;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .management-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }

            .action-buttons .btn-custom,
            .action-buttons .btn-outline-custom {
                justify-content: center;
            }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in-up {
            animation: fadeInUp 0.6s ease-out;
        }

        .fade-in-up:nth-child(1) { animation-delay: 0.1s; }
        .fade-in-up:nth-child(2) { animation-delay: 0.2s; }
        .fade-in-up:nth-child(3) { animation-delay: 0.3s; }
        .fade-in-up:nth-child(4) { animation-delay: 0.4s; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg admin-navbar">
            <div class="container-fluid">
                <a class="navbar-brand" href="Default.aspx">
                    <i class="fas fa-shield-alt me-2"></i>ArS Admin
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="#dashboard">
                                <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#management">
                                <i class="fas fa-cogs me-1"></i>Management
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#system">
                                <i class="fas fa-server me-1"></i>System
                            </a>
                        </li>
                    </ul>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="Default.aspx" target="_blank">
                                <i class="fas fa-external-link-alt me-1"></i>View Portfolio
                            </a>
                        </li>
                        <li class="nav-item">
                            <asp:LinkButton ID="lnkLogout" runat="server" CssClass="nav-link" OnClick="btnLogout_Click">
                                <i class="fas fa-sign-out-alt me-1"></i>Logout
                            </asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="admin-container">
            <!-- Hero Section -->
            <div class="admin-hero fade-in-up">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h1><i class="fas fa-tachometer-alt me-3"></i>Portfolio Admin Dashboard</h1>
                        <p>Welcome back, <asp:Literal ID="litUsername" runat="server" />! Manage your portfolio content and track system performance.</p>
                    </div>
                    <div class="col-md-4 text-end">
                        <div class="d-flex flex-column align-items-end">
                            <small class="text-muted">Last Login</small>
                            <strong><asp:Literal ID="litLoginTime" runat="server" /></strong>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Section -->
            <div class="stats-grid" id="dashboard">
                <div class="stat-card fade-in-up">
                    <div class="stat-icon">
                        <i class="fas fa-cogs"></i>
                    </div>
                    <div class="stat-number">15</div>
                    <div class="stat-label">Skills Ready</div>
                </div>
                <div class="stat-card fade-in-up">
                    <div class="stat-icon">
                        <i class="fas fa-folder-open"></i>
                    </div>
                    <div class="stat-number">8</div>
                    <div class="stat-label">Projects Active</div>
                </div>
                <div class="stat-card fade-in-up">
                    <div class="stat-icon">
                        <i class="fas fa-trophy"></i>
                    </div>
                    <div class="stat-number">12</div>
                    <div class="stat-label">Achievements</div>
                </div>
                <div class="stat-card fade-in-up">
                    <div class="stat-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="stat-number">5</div>
                    <div class="stat-label">New Messages</div>
                </div>
            </div>

            <!-- Management Section -->
            <div id="management">
                <h2 class="mb-4" style="color: #1e293b; font-weight: 700;">Portfolio Management & CRUD Operations</h2>
                
                <!-- Skills CRUD Section -->
                <div class="management-card fade-in-up">
                    <h5><i class="fas fa-cogs"></i>Skills CRUD Operations</h5>
                    <p>Add, edit, delete, and manage your technical skills with real-time database operations.</p>
                    
                    <!-- Add New Skill Form -->
                    <div class="mb-4">
                        <h6>Add New Skill</h6>
                        <div class="row g-3">
                            <div class="col-md-3">
                                <asp:TextBox ID="txtSkillName" runat="server" CssClass="form-control" placeholder="Skill Name" />
                            </div>
                            <div class="col-md-2">
                                <asp:DropDownList ID="ddlSkillCategory" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Select Category" Value="" />
                                    <asp:ListItem Text="Programming" Value="Programming" />
                                    <asp:ListItem Text="Framework" Value="Framework" />
                                    <asp:ListItem Text="Database" Value="Database" />
                                    <asp:ListItem Text="Mobile" Value="Mobile" />
                                    <asp:ListItem Text="Technology" Value="Technology" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-2">
                                <asp:TextBox ID="txtProficiency" runat="server" CssClass="form-control" placeholder="Proficiency (1-100)" TextMode="Number" />
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox ID="txtIconClass" runat="server" CssClass="form-control" placeholder="Icon Class (e.g., fas fa-code)" />
                            </div>
                            <div class="col-md-2">
                                <asp:Button ID="btnAddSkill" runat="server" CssClass="btn-custom w-100" Text="Add Skill" OnClick="btnAddSkill_Click" />
                            </div>
                        </div>
                        <div class="row g-3 mt-2">
                            <div class="col-md-12">
                                <asp:TextBox ID="txtSkillDescription" runat="server" CssClass="form-control" placeholder="Skill Description" TextMode="MultiLine" Rows="2" />
                            </div>
                        </div>
                    </div>

                    <!-- Skills List -->
                    <div class="mb-4">
                        <h6>Current Skills</h6>
                        <asp:UpdatePanel ID="UpdatePanelSkills" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvSkills" runat="server" CssClass="table table-striped" AutoGenerateColumns="false" 
                                    DataKeyNames="SkillId" OnRowCommand="gvSkills_RowCommand" OnRowEditing="gvSkills_RowEditing" 
                                    OnRowCancelingEdit="gvSkills_RowCancelingEdit" OnRowUpdating="gvSkills_RowUpdating" OnRowDeleting="gvSkills_RowDeleting">
                                    <Columns>
                                        <asp:BoundField DataField="SkillName" HeaderText="Skill Name" />
                                        <asp:BoundField DataField="SkillCategory" HeaderText="Category" />
                                        <asp:BoundField DataField="ProficiencyLevel" HeaderText="Proficiency %" />
                                        <asp:BoundField DataField="IconClass" HeaderText="Icon" />
                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>
                                                <asp:Button runat="server" CommandName="Edit" CssClass="btn btn-sm btn-outline-custom me-1" Text="Edit" />
                                                <asp:Button runat="server" CommandName="Delete" CommandArgument='<%# Eval("SkillId") %>' 
                                                    CssClass="btn btn-sm btn-outline-danger" Text="Delete" 
                                                    OnClientClick="return confirm('Are you sure you want to delete this skill?');" />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Button runat="server" CommandName="Update" CssClass="btn btn-sm btn-outline-custom me-1" Text="Update" />
                                                <asp:Button runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-outline-secondary" Text="Cancel" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div class="text-center py-3 text-muted">
                                            <i class="fas fa-info-circle me-2"></i>No skills found. Add your first skill above.
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                    <div class="action-buttons">
                        <a href="Skills.aspx" class="btn-custom" target="_blank">
                            <i class="fas fa-external-link-alt"></i>View Skills Page
                        </a>
                        <asp:Button ID="btnRefreshSkills" runat="server" CssClass="btn-outline-custom" Text="Refresh Skills" OnClick="btnRefreshSkills_Click" />
                    </div>
                </div>

                <!-- Projects CRUD Section -->
                <div class="management-card fade-in-up">
                    <h5><i class="fas fa-folder-open"></i>Projects CRUD Operations</h5>
                    <p>Manage your project portfolio with full CRUD capabilities.</p>
                    
                    <!-- Add New Project Form -->
                    <div class="mb-4">
                        <h6>Add New Project</h6>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <asp:TextBox ID="txtProjectTitle" runat="server" CssClass="form-control" placeholder="Project Title" />
                            </div>
                            <div class="col-md-3">
                                <asp:DropDownList ID="ddlProjectType" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Select Type" Value="" />
                                    <asp:ListItem Text="Web Application" Value="Web" />
                                    <asp:ListItem Text="Mobile App" Value="Mobile" />
                                    <asp:ListItem Text="Desktop App" Value="Desktop" />
                                    <asp:ListItem Text="API" Value="API" />
                                    <asp:ListItem Text="Machine Learning" Value="ML" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox ID="txtTechStack" runat="server" CssClass="form-control" placeholder="Tech Stack" />
                            </div>
                            <div class="col-md-2">
                                <asp:Button ID="btnAddProject" runat="server" CssClass="btn-custom w-100" Text="Add Project" OnClick="btnAddProject_Click" />
                            </div>
                        </div>
                        <div class="row g-3 mt-2">
                            <div class="col-md-6">
                                <asp:TextBox ID="txtProjectDescription" runat="server" CssClass="form-control" placeholder="Project Description" TextMode="MultiLine" Rows="2" />
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox ID="txtGitHubLink" runat="server" CssClass="form-control" placeholder="GitHub Link" />
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox ID="txtDemoLink" runat="server" CssClass="form-control" placeholder="Demo Link" />
                            </div>
                        </div>
                    </div>

                    <!-- Projects List -->
                    <div class="mb-4">
                        <h6>Current Projects</h6>
                        <asp:UpdatePanel ID="UpdatePanelProjects" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvProjects" runat="server" CssClass="table table-striped" AutoGenerateColumns="false" 
                                    DataKeyNames="ProjectId" OnRowDeleting="gvProjects_RowDeleting">
                                    <Columns>
                                        <asp:BoundField DataField="Title" HeaderText="Title" />
                                        <asp:BoundField DataField="ProjectType" HeaderText="Type" />
                                        <asp:BoundField DataField="TechStack" HeaderText="Tech Stack" />
                                        <asp:BoundField DataField="Status" HeaderText="Status" />
                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>
                                                <asp:Button runat="server" CommandName="Delete" CommandArgument='<%# Eval("ProjectId") %>' 
                                                    CssClass="btn btn-sm btn-outline-danger" Text="Delete" 
                                                    OnClientClick="return confirm('Are you sure you want to delete this project?');" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div class="text-center py-3 text-muted">
                                            <i class="fas fa-info-circle me-2"></i>No projects found. Add your first project above.
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                    <div class="action-buttons">
                        <a href="Projects.aspx" class="btn-custom" target="_blank">
                            <i class="fas fa-external-link-alt"></i>View Projects Page
                        </a>
                        <asp:Button ID="btnRefreshProjects" runat="server" CssClass="btn-outline-custom" Text="Refresh Projects" OnClick="btnRefreshProjects_Click" />
                    </div>
                </div>

                <!-- Achievements CRUD Section -->
                <div class="management-card fade-in-up">
                    <h5><i class="fas fa-trophy"></i>Achievements CRUD Operations</h5>
                    <p>Track and manage your achievements and certifications.</p>
                    
                    <!-- Add New Achievement Form -->
                    <div class="mb-4">
                        <h6>Add New Achievement</h6>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <asp:TextBox ID="txtAchievementTitle" runat="server" CssClass="form-control" placeholder="Achievement Title" />
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox ID="txtOrganization" runat="server" CssClass="form-control" placeholder="Organization" />
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox ID="txtAchievementDate" runat="server" CssClass="form-control" placeholder="Achievement Date" TextMode="Date" />
                            </div>
                            <div class="col-md-2">
                                <asp:Button ID="btnAddAchievement" runat="server" CssClass="btn-custom w-100" Text="Add Achievement" OnClick="btnAddAchievement_Click" />
                            </div>
                        </div>
                        <div class="row g-3 mt-2">
                            <div class="col-md-6">
                                <asp:TextBox ID="txtAchievementDescription" runat="server" CssClass="form-control" placeholder="Achievement Description" TextMode="MultiLine" Rows="2" />
                            </div>
                            <div class="col-md-6">
                                <asp:TextBox ID="txtAchievementCategory" runat="server" CssClass="form-control" placeholder="Category (e.g., Certification, Award)" />
                            </div>
                        </div>
                    </div>

                    <!-- Achievements List -->
                    <div class="mb-4">
                        <h6>Current Achievements</h6>
                        <asp:UpdatePanel ID="UpdatePanelAchievements" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvAchievements" runat="server" CssClass="table table-striped" AutoGenerateColumns="false" 
                                    DataKeyNames="AchievementId" OnRowDeleting="gvAchievements_RowDeleting">
                                    <Columns>
                                        <asp:BoundField DataField="Title" HeaderText="Title" />
                                        <asp:BoundField DataField="Organization" HeaderText="Organization" />
                                        <asp:BoundField DataField="Category" HeaderText="Category" />
                                        <asp:BoundField DataField="AchievementDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>
                                                <asp:Button runat="server" CommandName="Delete" CommandArgument='<%# Eval("AchievementId") %>' 
                                                    CssClass="btn btn-sm btn-outline-danger" Text="Delete" 
                                                    OnClientClick="return confirm('Are you sure you want to delete this achievement?');" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div class="text-center py-3 text-muted">
                                            <i class="fas fa-info-circle me-2"></i>No achievements found. Add your first achievement above.
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                    <div class="action-buttons">
                        <a href="Achievements.aspx" class="btn-custom" target="_blank">
                            <i class="fas fa-external-link-alt"></i>View Achievements Page
                        </a>
                        <asp:Button ID="btnRefreshAchievements" runat="server" CssClass="btn-outline-custom" Text="Refresh Achievements" OnClick="btnRefreshAchievements_Click" />
                    </div>
                </div>
            </div>

            <!-- System Status Section -->
            <div id="system">
                <h2 class="mb-4" style="color: #1e293b; font-weight: 700;">System Status</h2>
                <div class="management-card fade-in-up">
                    <h5><i class="fas fa-server"></i>System Information</h5>
                    <div class="status-grid">
                        <div>
                            <div class="status-item">
                                <div class="status-icon">
                                    <i class="fas fa-check"></i>
                                </div>
                                <div>
                                    <div class="status-text">Authentication</div>
                                    <div class="status-value">Active & Secure</div>
                                </div>
                            </div>
                            <div class="status-item">
                                <div class="status-icon">
                                    <i class="fas fa-database"></i>
                                </div>
                                <div>
                                    <div class="status-text">Database</div>
                                    <div class="status-value">Connected & Ready</div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="status-item">
                                <div class="status-icon">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div>
                                    <div class="status-text">Username</div>
                                    <div class="status-value"><asp:Literal ID="litUserDisplay" runat="server" /></div>
                                </div>
                            </div>
                            <div class="status-item">
                                <div class="status-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div>
                                    <div class="status-text">Session ID</div>
                                    <div class="status-value"><asp:Literal ID="litSessionId" runat="server" /></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="management-card fade-in-up">
                <h5><i class="fas fa-bolt"></i>Quick Actions</h5>
                <div class="action-buttons">
                    <a href="Default.aspx" class="btn-custom" target="_blank">
                        <i class="fas fa-home"></i>Portfolio Home
                    </a>
                    <button class="btn-outline-custom" onclick="location.reload()">
                        <i class="fas fa-sync"></i>Refresh Dashboard
                    </button>
                    <asp:Button ID="btnLogout" runat="server" CssClass="btn-outline-custom" OnClick="btnLogout_Click"
                        Text="<i class='fas fa-sign-out-alt'></i> Secure Logout" />
                </div>
            </div>

            <!-- Success Message -->
            <div class="alert alert-custom fade-in-up">
                <div class="d-flex align-items-center">
                    <i class="fas fa-check-circle me-3" style="font-size: 1.5rem; color: #14B8A6;"></i>
                    <div>
                        <h6 class="mb-1" style="color: #1e293b;">Portfolio Admin System Active</h6>
                        <p class="mb-0" style="color: #64748b;">Your admin panel is fully operational. All systems are running smoothly and ready for content management.</p>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate stats counters
            const statNumbers = document.querySelectorAll('.stat-number');
            
            const animateCounter = (element) => {
                const target = parseInt(element.textContent);
                if (target > 0) {
                    let current = 0;
                    const increment = target / 50;
                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= target) {
                            element.textContent = target;
                            clearInterval(timer);
                        } else {
                            element.textContent = Math.floor(current);
                        }
                    }, 40);
                }
            };

            // Intersection Observer for animations
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                        
                        // Animate counters when stats section comes into view
                        if (entry.target.classList.contains('stat-card')) {
                            const number = entry.target.querySelector('.stat-number');
                            if (number) {
                                setTimeout(() => animateCounter(number), 200);
                            }
                        }
                    }
                });
            }, { threshold: 0.1 });

            // Observe all animated elements
            document.querySelectorAll('.fade-in-up').forEach(el => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(30px)';
                el.style.transition = 'all 0.6s ease';
                observer.observe(el);
            });

            // Smooth scroll for navigation
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });

            console.log('Portfolio Admin Dashboard loaded successfully!');
        });
    </script>
</body>
</html>