<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebApplication1.Admin.Dashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard - Portfolio</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <!-- Custom CSS -->
    <link href="../Content/Site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <!-- Admin Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-success">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="Dashboard.aspx">
                    <i class="fas fa-tachometer-alt me-2"></i>Portfolio Admin
                </a>
                
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="adminNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="Dashboard.aspx">
                                <i class="fas fa-home me-1"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ManageSkills.aspx">
                                <i class="fas fa-cogs me-1"></i>Skills
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ManageProjects.aspx">
                                <i class="fas fa-folder-open me-1"></i>Projects
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ManageAchievements.aspx">
                                <i class="fas fa-trophy me-1"></i>Achievements
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ManageEducation.aspx">
                                <i class="fas fa-graduation-cap me-1"></i>Education
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ManageCertificates.aspx">
                                <i class="fas fa-certificate me-1"></i>Certificates
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ManageMessages.aspx">
                                <i class="fas fa-envelope me-1"></i>Messages
                                <asp:Literal ID="litUnreadCount" runat="server" />
                            </a>
                        </li>
                    </ul>
                    
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user me-1"></i>
                                <asp:Literal ID="litAdminName" runat="server" />
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="Profile.aspx">
                                    <i class="fas fa-user-edit me-2"></i>Profile Settings
                                </a></li>
                                <li><a class="dropdown-item" href="../Default.aspx" target="_blank">
                                    <i class="fas fa-external-link-alt me-2"></i>View Site
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><asp:LinkButton ID="lnkLogout" runat="server" CssClass="dropdown-item" OnClick="lnkLogout_Click">
                                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                                </asp:LinkButton></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="container-fluid py-4">
            <!-- Welcome Section -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h1 class="h3 mb-1">Welcome back, <asp:Literal ID="litWelcomeName" runat="server" />!</h1>
                            <p class="text-muted mb-0">Here's what's happening with your portfolio today.</p>
                        </div>
                        <div class="text-end">
                            <small class="text-muted">
                                Last login: <asp:Literal ID="litLastLogin" runat="server" />
                            </small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card bg-primary text-white h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4 class="mb-0"><asp:Literal ID="litProjectsCount" runat="server" /></h4>
                                    <p class="mb-0">Projects</p>
                                </div>
                                <i class="fas fa-folder-open fa-2x opacity-75"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-primary bg-opacity-25">
                            <a href="ManageProjects.aspx" class="text-white text-decoration-none">
                                <small>Manage Projects <i class="fas fa-arrow-right ms-1"></i></small>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card bg-success text-white h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4 class="mb-0"><asp:Literal ID="litSkillsCount" runat="server" /></h4>
                                    <p class="mb-0">Skills</p>
                                </div>
                                <i class="fas fa-cogs fa-2x opacity-75"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-success bg-opacity-25">
                            <a href="ManageSkills.aspx" class="text-white text-decoration-none">
                                <small>Manage Skills <i class="fas fa-arrow-right ms-1"></i></small>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card bg-warning text-white h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4 class="mb-0"><asp:Literal ID="litAchievementsCount" runat="server" /></h4>
                                    <p class="mb-0">Achievements</p>
                                </div>
                                <i class="fas fa-trophy fa-2x opacity-75"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-warning bg-opacity-25">
                            <a href="ManageAchievements.aspx" class="text-white text-decoration-none">
                                <small>Manage Achievements <i class="fas fa-arrow-right ms-1"></i></small>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card bg-info text-white h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4 class="mb-0"><asp:Literal ID="litMessagesCount" runat="server" /></h4>
                                    <p class="mb-0">Messages</p>
                                </div>
                                <i class="fas fa-envelope fa-2x opacity-75"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-info bg-opacity-25">
                            <a href="ManageMessages.aspx" class="text-white text-decoration-none">
                                <small>View Messages <i class="fas fa-arrow-right ms-1"></i></small>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="row">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-envelope me-2"></i>Recent Messages
                            </h5>
                        </div>
                        <div class="card-body">
                            <asp:Repeater ID="rptRecentMessages" runat="server">
                                <HeaderTemplate>
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Name</th>
                                                    <th>Email</th>
                                                    <th>Subject</th>
                                                    <th>Date</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("Name") %></td>
                                        <td><%# Eval("Email") %></td>
                                        <td><%# Eval("Subject") %></td>
                                        <td><%# Convert.ToDateTime(Eval("ReceivedDate")).ToString("MMM dd, yyyy") %></td>
                                        <td>
                                            <span class="badge bg-<%# Convert.ToBoolean(Eval("IsRead")) ? "success" : "warning" %>">
                                                <%# Convert.ToBoolean(Eval("IsRead")) ? "Read" : "Unread" %>
                                            </span>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                            </tbody>
                                        </table>
                                    </div>
                                </FooterTemplate>
                            </asp:Repeater>
                            
                            <asp:Panel ID="pnlNoMessages" runat="server" Visible="false">
                                <div class="text-center py-3 text-muted">
                                    <i class="fas fa-inbox fa-3x mb-3"></i>
                                    <p>No messages yet.</p>
                                </div>
                            </asp:Panel>
                            
                            <div class="text-center mt-3">
                                <a href="ManageMessages.aspx" class="btn btn-outline-primary">
                                    <i class="fas fa-eye me-2"></i>View All Messages
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-chart-line me-2"></i>Quick Actions
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <a href="ManageProjects.aspx" class="btn btn-primary">
                                    <i class="fas fa-plus me-2"></i>Add New Project
                                </a>
                                <a href="ManageSkills.aspx" class="btn btn-success">
                                    <i class="fas fa-plus me-2"></i>Add New Skill
                                </a>
                                <a href="ManageAchievements.aspx" class="btn btn-warning">
                                    <i class="fas fa-plus me-2"></i>Add Achievement
                                </a>
                                <a href="Profile.aspx" class="btn btn-info">
                                    <i class="fas fa-edit me-2"></i>Update Profile
                                </a>
                                <a href="../Default.aspx" target="_blank" class="btn btn-outline-secondary">
                                    <i class="fas fa-external-link-alt me-2"></i>View Live Site
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- System Info -->
                    <div class="card mt-3">
                        <div class="card-header">
                            <h6 class="mb-0">
                                <i class="fas fa-info-circle me-2"></i>System Information
                            </h6>
                        </div>
                        <div class="card-body">
                            <small class="text-muted">
                                <div class="mb-2">
                                    <strong>Login Time:</strong><br>
                                    <asp:Literal ID="litCurrentSession" runat="server" />
                                </div>
                                <div class="mb-2">
                                    <strong>IP Address:</strong><br>
                                    <asp:Literal ID="litIPAddress" runat="server" />
                                </div>
                                <div>
                                    <strong>Last Activity:</strong><br>
                                    <asp:Literal ID="litLastActivity" runat="server" />
                                </div>
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Auto refresh stats every 5 minutes
            setTimeout(function() {
                location.reload();
            }, 300000);
            
            // Update last activity time
            setInterval(function() {
                document.getElementById('<%= litLastActivity.ClientID %>').textContent = new Date().toLocaleString();
            }, 60000);
        });
    </script>
</body>
</html>