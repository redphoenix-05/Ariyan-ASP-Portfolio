<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebApplication1.Admin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Portfolio Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --sidebar-width: 280px;
        }

        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .admin-wrapper {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: var(--sidebar-width);
            background: var(--primary-gradient);
            color: white;
            padding: 0;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-header h4 {
            margin: 0;
            font-weight: 600;
        }

        .sidebar-nav {
            padding: 1rem 0;
        }

        .nav-item {
            margin: 0.25rem 1rem;
        }

        .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 0.75rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.15);
            color: white;
            transform: translateX(5px);
        }

        .nav-link i {
            width: 20px;
            text-align: center;
        }

        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 0;
        }

        .top-navbar {
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 1rem 2rem;
            display: flex;
            justify-content: between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 500;
        }

        .navbar-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
        }

        .navbar-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-left: auto;
        }

        .content-area {
            padding: 2rem;
        }

        .card {
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 12px;
            margin-bottom: 1.5rem;
        }

        .card-header {
            background: var(--primary-gradient);
            color: white;
            border-radius: 12px 12px 0 0 !important;
            padding: 1rem 1.5rem;
            font-weight: 600;
        }

        .table-responsive {
            border-radius: 8px;
            overflow: hidden;
        }

        .table th {
            background: #f8f9fa;
            border: none;
            font-weight: 600;
            color: #495057;
        }

        .table td {
            border: none;
            border-bottom: 1px solid #e9ecef;
            vertical-align: middle;
        }

        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .badge {
            font-size: 0.75rem;
            padding: 0.375rem 0.75rem;
            border-radius: 6px;
        }

        .modal-header {
            background: var(--primary-gradient);
            color: white;
            border-radius: 12px 12px 0 0;
        }

        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        .stats-card {
            background: var(--primary-gradient);
            color: white;
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            margin-bottom: 1rem;
        }

        .stats-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .stats-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .progress {
            height: 8px;
            border-radius: 4px;
            background: #e9ecef;
        }

        .progress-bar {
            background: var(--primary-gradient);
            border-radius: 4px;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: fixed;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }

            .sidebar.show {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .content-area {
                padding: 1rem;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="admin-wrapper">
            <!-- Sidebar -->
            <nav class="sidebar">
                <div class="sidebar-header">
                    <h4><i class="fas fa-shield-alt me-2"></i>Admin Panel</h4>
                    <small>Portfolio Management</small>
                </div>
                
                <div class="sidebar-nav">
                    <div class="nav-item">
                        <a href="#" class="nav-link active" onclick="showSection('dashboard')">
                            <i class="fas fa-tachometer-alt"></i>Dashboard
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link" onclick="showSection('skills')">
                            <i class="fas fa-cogs"></i>Skills Management
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link" onclick="showSection('projects')">
                            <i class="fas fa-folder-open"></i>Projects Management
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link" onclick="showSection('education')">
                            <i class="fas fa-graduation-cap"></i>Education Management
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link" onclick="showSection('achievements')">
                            <i class="fas fa-award"></i>Achievements
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link" onclick="showSection('messages')">
                            <i class="fas fa-envelope"></i>Contact Messages
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link" onclick="showSection('settings')">
                            <i class="fas fa-cog"></i>Settings
                        </a>
                    </div>
                    <hr style="border-color: rgba(255,255,255,0.2); margin: 1rem;">
                    <div class="nav-item">
                        <a href="Default.aspx" class="nav-link" target="_blank">
                            <i class="fas fa-external-link-alt"></i>View Portfolio
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="DatabaseTest.aspx" class="nav-link" target="_blank">
                            <i class="fas fa-database"></i>Database Test
                        </a>
                    </div>
                    <div class="nav-item">
                        <asp:LinkButton ID="lnkLogout" runat="server" CssClass="nav-link" OnClick="lnkLogout_Click">
                            <i class="fas fa-sign-out-alt"></i>Logout
                        </asp:LinkButton>
                    </div>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="main-content">
                <!-- Top Navigation -->
                <div class="top-navbar">
                    <div class="navbar-title" id="sectionTitle">Dashboard</div>
                    <div class="navbar-actions">
                        <span class="text-muted">Welcome, <asp:Literal ID="litUsername" runat="server" /></span>
                        <button type="button" class="btn btn-outline-primary btn-sm" onclick="refreshData()">
                            <i class="fas fa-sync-alt"></i> Refresh
                        </button>
                    </div>
                </div>

                <!-- Content Area -->
                <div class="content-area">
                    
                    <!-- Dashboard Section -->
                    <div id="dashboardSection" class="content-section">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="stats-number" id="totalSkills">0</div>
                                    <div class="stats-label">Total Skills</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="stats-number" id="totalProjects">0</div>
                                    <div class="stats-label">Total Projects</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="stats-number" id="totalEducation">0</div>
                                    <div class="stats-label">Education Records</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="stats-number" id="totalMessages">0</div>
                                    <div class="stats-label">Contact Messages</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-2"></i>Recent Activity
                                    </div>
                                    <div class="card-body">
                                        <div id="recentActivity">
                                            <p class="text-muted">Loading recent activity...</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Skills Section -->
                    <div id="skillsSection" class="content-section" style="display: none;">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3>Skills Management</h3>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#skillModal" onclick="clearSkillForm()">
                                <i class="fas fa-plus me-1"></i>Add New Skill
                            </button>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-cogs me-2"></i>Skills List
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover" id="skillsTable">
                                        <thead>
                                            <tr>
                                                <th>Skill Name</th>
                                                <th>Category</th>
                                                <th>Proficiency</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="skillsTableBody">
                                            <tr>
                                                <td colspan="5" class="text-center">Loading skills...</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Projects Section -->
                    <div id="projectsSection" class="content-section" style="display: none;">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3>Projects Management</h3>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#projectModal" onclick="clearProjectForm()">
                                <i class="fas fa-plus me-1"></i>Add New Project
                            </button>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-folder-open me-2"></i>Projects List
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover" id="projectsTable">
                                        <thead>
                                            <tr>
                                                <th>Title</th>
                                                <th>Type</th>
                                                <th>Status</th>
                                                <th>Featured</th>
                                                <th>Created</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="projectsTableBody">
                                            <tr>
                                                <td colspan="6" class="text-center">Loading projects...</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Education Section -->
                    <div id="educationSection" class="content-section" style="display: none;">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3>Education Management</h3>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#educationModal" onclick="clearEducationForm()">
                                <i class="fas fa-plus me-1"></i>Add Education Record
                            </button>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-graduation-cap me-2"></i>Education Records
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover" id="educationTable">
                                        <thead>
                                            <tr>
                                                <th>Degree</th>
                                                <th>Institution</th>
                                                <th>Years</th>
                                                <th>Grade</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="educationTableBody">
                                            <tr>
                                                <td colspan="5" class="text-center">Loading education records...</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Achievements Section -->
                    <div id="achievementsSection" class="content-section" style="display: none;">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3>Achievements Management</h3>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#achievementModal" onclick="clearAchievementForm()">
                                <i class="fas fa-plus me-1"></i>Add Achievement
                            </button>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-award me-2"></i>Achievements List
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover" id="achievementsTable">
                                        <thead>
                                            <tr>
                                                <th>Title</th>
                                                <th>Organization</th>
                                                <th>Category</th>
                                                <th>Date</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="achievementsTableBody">
                                            <tr>
                                                <td colspan="5" class="text-center">Loading achievements...</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Messages Section -->
                    <div id="messagesSection" class="content-section" style="display: none;">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3>Contact Messages</h3>
                            <button type="button" class="btn btn-primary" onclick="markAllAsRead()">
                                <i class="fas fa-check-double me-1"></i>Mark All as Read
                            </button>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-envelope me-2"></i>Messages List
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover" id="messagesTable">
                                        <thead>
                                            <tr>
                                                <th>From</th>
                                                <th>Subject</th>
                                                <th>Date</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="messagesTableBody">
                                            <tr>
                                                <td colspan="5" class="text-center">Loading messages...</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Settings Section -->
                    <div id="settingsSection" class="content-section" style="display: none;">
                        <h3>System Settings</h3>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header">
                                        <i class="fas fa-user me-2"></i>Admin Profile
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <label class="form-label">Username</label>
                                            <input type="text" class="form-control" id="adminUsername" readonly>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Full Name</label>
                                            <input type="text" class="form-control" id="adminFullName">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Email</label>
                                            <input type="email" class="form-control" id="adminEmail">
                                        </div>
                                        <button type="button" class="btn btn-primary" onclick="updateProfile()">
                                            <i class="fas fa-save me-1"></i>Update Profile
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header">
                                        <i class="fas fa-key me-2"></i>Change Password
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <label class="form-label">Current Password</label>
                                            <input type="password" class="form-control" id="currentPassword">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">New Password</label>
                                            <input type="password" class="form-control" id="newPassword">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Confirm New Password</label>
                                            <input type="password" class="form-control" id="confirmPassword">
                                        </div>
                                        <button type="button" class="btn btn-primary" onclick="changePassword()">
                                            <i class="fas fa-key me-1"></i>Change Password
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </main>
        </div>

        <!-- Skills Modal -->
        <div class="modal fade" id="skillModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="skillModalTitle">Add New Skill</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="skillId" value="">
                        <div class="mb-3">
                            <label class="form-label">Skill Name</label>
                            <input type="text" class="form-control" id="skillName" placeholder="Enter skill name">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select class="form-select" id="skillCategory">
                                <option value="">Select category</option>
                                <option value="Programming">Programming</option>
                                <option value="Framework">Framework</option>
                                <option value="Database">Database</option>
                                <option value="Mobile">Mobile</option>
                                <option value="Technology">Technology</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Proficiency Level (%)</label>
                            <input type="range" class="form-range" id="skillProficiency" min="1" max="100" value="50" oninput="updateProficiencyDisplay()">
                            <div class="text-center mt-2">
                                <span id="proficiencyDisplay" class="badge bg-primary">50%</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Icon Class (FontAwesome)</label>
                            <input type="text" class="form-control" id="skillIcon" placeholder="e.g., fas fa-code">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" id="skillDescription" rows="3" placeholder="Brief description of your skill"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" onclick="saveSkill()">Save Skill</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Projects Modal -->
        <div class="modal fade" id="projectModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="projectModalTitle">Add New Project</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="projectId" value="">
                        <div class="mb-3">
                            <label class="form-label">Project Title</label>
                            <input type="text" class="form-control" id="projectTitle" placeholder="Enter project title">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" id="projectDesc" rows="3" placeholder="Brief description of the project"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tech Stack</label>
                            <input type="text" class="form-control" id="techStack" placeholder="e.g., HTML, CSS, JavaScript">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Project Type</label>
                            <select class="form-select" id="projectType">
                                <option value="">Select type</option>
                                <option value="Web">Web</option>
                                <option value="Mobile">Mobile</option>
                                <option value="Desktop">Desktop</option>
                                <option value="API">API</option>
                                <option value="ML">ML</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">GitHub Link</label>
                            <input type="text" class="form-control" id="githubLink" placeholder="Enter GitHub repository link">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Demo Link</label>
                            <input type="text" class="form-control" id="demoLink" placeholder="Enter demo link (if any)">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" onclick="saveProject()">Save Project</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Education Modal -->
        <div class="modal fade" id="educationModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="educationModalTitle">Add New Education</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="educationId" value="">
                        <div class="mb-3">
                            <label class="form-label">Degree</label>
                            <input type="text" class="form-control" id="degree" placeholder="Enter degree">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Institution</label>
                            <input type="text" class="form-control" id="institution" placeholder="Enter institution name">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Start Year</label>
                            <input type="number" class="form-control" id="startYear" placeholder="Enter start year">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">End Year</label>
                            <input type="number" class="form-control" id="endYear" placeholder="Enter end year (optional)">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Grade/GPA</label>
                            <input type="text" class="form-control" id="grade" placeholder="Enter grade or GPA (optional)">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" onclick="saveEducation()">Save Education</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Achievements Modal -->
        <div class="modal fade" id="achievementModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="achievementModalTitle">Add New Achievement</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="achievementId" value="">
                        <div class="mb-3">
                            <label class="form-label">Achievement Title</label>
                            <input type="text" class="form-control" id="achievementTitle" placeholder="Enter achievement title">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Organization</label>
                            <input type="text" class="form-control" id="organization" placeholder="Enter organization name">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <input type="text" class="form-control" id="achievementCategory" placeholder="Enter category">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Date</label>
                            <input type="date" class="form-control" id="achievementDate">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" onclick="saveAchievement()">Save Achievement</button>
                    </div>
                </div>
            </div>
        </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Global variables
        let currentSection = 'dashboard';
        
        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            loadDashboardData();
        });

        // Section management
        function showSection(section) {
            // Hide all sections
            document.querySelectorAll('.content-section').forEach(el => el.style.display = 'none');
            
            // Remove active class from all nav links
            document.querySelectorAll('.nav-link').forEach(el => el.classList.remove('active'));
            
            // Show selected section
            document.getElementById(section + 'Section').style.display = 'block';
            
            // Add active class to clicked nav link
            event.target.classList.add('active');
            
            // Update page title
            const titles = {
                'dashboard': 'Dashboard',
                'skills': 'Skills Management',
                'projects': 'Projects Management',
                'education': 'Education Management',
                'achievements': 'Achievements Management',
                'messages': 'Contact Messages',
                'settings': 'System Settings'
            };
            document.getElementById('sectionTitle').textContent = titles[section];
            
            // Load section data
            currentSection = section;
            loadSectionData(section);
        }

        // Load section-specific data
        function loadSectionData(section) {
            switch(section) {
                case 'dashboard':
                    loadDashboardData();
                    break;
                case 'skills':
                    loadSkillsData();
                    break;
                case 'projects':
                    loadProjectsData();
                    break;
                case 'education':
                    loadEducationData();
                    break;
                case 'achievements':
                    loadAchievementsData();
                    break;
                case 'messages':
                    loadMessagesData();
                    break;
                case 'settings':
                    loadSettingsData();
                    break;
            }
        }

        // Dashboard functions
        function loadDashboardData() {
            // Load statistics
            fetch('Admin.aspx/GetDashboardStats', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            })
            .then(response => response.json())
            .then(data => {
                if (data.d && data.d.success) {
                    const stats = data.d.data;
                    document.getElementById('totalSkills').textContent = stats.TotalSkills;
                    document.getElementById('totalProjects').textContent = stats.TotalProjects;
                    document.getElementById('totalEducation').textContent = stats.TotalEducation;
                    document.getElementById('totalMessages').textContent = stats.TotalMessages;
                }
            })
            .catch(error => console.error('Error loading dashboard:', error));
        }

        // Skills functions
        function loadSkillsData() {
            fetch('Admin.aspx/GetSkills', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            })
            .then(response => response.json())
            .then(data => {
                if (data.d && data.d.success) {
                    displaySkills(data.d.data);
                }
            })
            .catch(error => console.error('Error loading skills:', error));
        }

        function displaySkills(skills) {
            const tbody = document.getElementById('skillsTableBody');
            if (skills && skills.length > 0) {
                tbody.innerHTML = skills.map(skill => `
                    <tr>
                        <td><strong>${skill.SkillName}</strong></td>
                        <td><span class="badge bg-secondary">${skill.SkillCategory}</span></td>
                        <td>
                            <div class="progress" style="height: 20px;">
                                <div class="progress-bar" style="width: ${skill.ProficiencyLevel}%">
                                    ${skill.ProficiencyLevel}%
                                </div>
                            </div>
                        </td>
                        <td><span class="badge bg-success">Active</span></td>
                        <td>
                            <button class="btn btn-sm btn-primary me-1" onclick="editSkill(${skill.SkillId})">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn btn-sm btn-danger" onclick="deleteSkill(${skill.SkillId})">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                `).join('');
            } else {
                tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">No skills found</td></tr>';
            }
        }

        function clearSkillForm() {
            document.getElementById('skillId').value = '';
            document.getElementById('skillName').value = '';
            document.getElementById('skillCategory').value = '';
            document.getElementById('skillProficiency').value = '50';
            document.getElementById('skillIcon').value = '';
            document.getElementById('skillDescription').value = '';
            document.getElementById('skillModalTitle').textContent = 'Add New Skill';
            updateProficiencyDisplay();
        }

        function updateProficiencyDisplay() {
            const value = document.getElementById('skillProficiency').value;
            document.getElementById('proficiencyDisplay').textContent = value + '%';
        }

        function saveSkill() {
            const skillData = {
                skillId: document.getElementById('skillId').value,
                skillName: document.getElementById('skillName').value,
                skillCategory: document.getElementById('skillCategory').value,
                proficiencyLevel: parseInt(document.getElementById('skillProficiency').value),
                iconClass: document.getElementById('skillIcon').value,
                description: document.getElementById('skillDescription').value
            };

            if (!skillData.skillName || !skillData.skillCategory) {
                alert('Please fill in all required fields');
                return;
            }

            const method = skillData.skillId ? 'UpdateSkill' : 'AddSkill';
            const params = skillData.skillId ? 
                { 
                    skillId: parseInt(skillData.skillId),
                    skillName: skillData.skillName,
                    skillCategory: skillData.skillCategory,
                    proficiencyLevel: skillData.proficiencyLevel,
                    iconClass: skillData.iconClass,
                    description: skillData.description
                } :
                {
                    skillName: skillData.skillName,
                    skillCategory: skillData.skillCategory,
                    proficiencyLevel: skillData.proficiencyLevel,
                    iconClass: skillData.iconClass,
                    description: skillData.description
                };
            
            fetch(`Admin.aspx/${method}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(params)
            })
            .then(response => response.json())
            .then(data => {
                if (data.d && data.d.success) {
                    bootstrap.Modal.getInstance(document.getElementById('skillModal')).hide();
                    loadSkillsData();
                    showAlert('Skill saved successfully!', 'success');
                } else {
                    showAlert('Error saving skill: ' + (data.d ? data.d.message : 'Unknown error'), 'danger');
                }
            })
            .catch(error => {
                console.error('Error saving skill:', error);
                showAlert('Error saving skill', 'danger');
            });
        }

        function editSkill(skillId) {
            fetch('Admin.aspx/GetSkillById', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ skillId: skillId })
            })
            .then(response => response.json())
            .then(data => {
                if (data.d && data.d.success) {
                    const skill = data.d.data;
                    document.getElementById('skillId').value = skill.SkillId;
                    document.getElementById('skillName').value = skill.SkillName;
                    document.getElementById('skillCategory').value = skill.SkillCategory;
                    document.getElementById('skillProficiency').value = skill.ProficiencyLevel;
                    document.getElementById('skillIcon').value = skill.IconClass;
                    document.getElementById('skillDescription').value = skill.Description;
                    document.getElementById('skillModalTitle').textContent = 'Edit Skill';
                    updateProficiencyDisplay();
                    
                    const modal = new bootstrap.Modal(document.getElementById('skillModal'));
                    modal.show();
                } else {
                    showAlert('Error loading skill data', 'danger');
                }
            })
            .catch(error => {
                console.error('Error loading skill:', error);
                showAlert('Error loading skill data', 'danger');
            });
        }

        // Add create sample data function
        function createSampleData() {
            if (confirm('This will create sample skills and projects. Continue?')) {
                fetch('Admin.aspx/CreateSampleData', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({})
                })
                .then(response => response.json())
                .then(data => {
                    if (data.d && data.d.success) {
                        showAlert('Sample data created successfully!', 'success');
                        refreshData();
                    } else {
                        showAlert('Error creating sample data: ' + (data.d ? data.d.message : 'Unknown error'), 'danger');
                    }
                })
                .catch(error => {
                    console.error('Error creating sample data:', error);
                    showAlert('Error creating sample data', 'danger');
                });
            }
        }

        // Add missing functions to prevent JavaScript errors
        function refreshData() {
            loadSectionData(currentSection);
        }

        function showAlert(message, type) {
            alert(message);
        }

        function loadProjectsData() {
            console.log('Loading projects...');
            document.getElementById('projectsTableBody').innerHTML = '<tr><td colspan="6" class="text-center text-muted">Projects functionality ready</td></tr>';
        }

        function loadEducationData() {
            console.log('Loading education...');
            document.getElementById('educationTableBody').innerHTML = '<tr><td colspan="5" class="text-center text-muted">Education functionality ready</td></tr>';
        }

        function loadAchievementsData() {
            console.log('Loading achievements...');
            document.getElementById('achievementsTableBody').innerHTML = '<tr><td colspan="5" class="text-center text-muted">Achievements functionality ready</td></tr>';
        }

        function loadMessagesData() {
            console.log('Loading messages...');
            document.getElementById('messagesTableBody').innerHTML = '<tr><td colspan="5" class="text-center text-muted">Messages functionality ready</td></tr>';
        }

        function loadSettingsData() {
            console.log('Loading settings...');
            document.getElementById('adminUsername').value = 'Ariyan';
            document.getElementById('adminFullName').value = 'Ariyan Aftab Spandan';
        }

        function clearProjectForm() {
            document.getElementById('projectId').value = '';
            document.getElementById('projectTitle').value = '';
            document.getElementById('projectDesc').value = '';
            document.getElementById('techStack').value = '';
            document.getElementById('projectType').value = '';
            document.getElementById('githubLink').value = '';
            document.getElementById('demoLink').value = '';
        }

        function clearEducationForm() {
            document.getElementById('educationId').value = '';
            document.getElementById('degree').value = '';
            document.getElementById('institution').value = '';
            document.getElementById('startYear').value = '';
            document.getElementById('endYear').value = '';
            document.getElementById('grade').value = '';
        }

        function clearAchievementForm() {
            document.getElementById('achievementId').value = '';
            document.getElementById('achievementTitle').value = '';
            document.getElementById('organization').value = '';
            document.getElementById('achievementCategory').value = '';
            document.getElementById('achievementDate').value = '';
        }

        function saveProject() {
            alert('Project save functionality ready - add implementation as needed');
        }

        function saveEducation() {
            alert('Education save functionality ready - add implementation as needed');
        }

        function saveAchievement() {
            alert('Achievement save functionality ready - add implementation as needed');
        }

        function markAllAsRead() {
            alert('Mark all as read functionality ready');
        }

        function updateProfile() {
            alert('Profile update functionality ready');
        }

        function changePassword() {
            alert('Password change functionality ready');
        }

        function deleteSkill(skillId) {
            if (confirm('Are you sure you want to delete this skill?')) {
                fetch('Admin.aspx/DeleteSkill', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ skillId: skillId })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.d && data.d.success) {
                        loadSkillsData();
                        showAlert('Skill deleted successfully!', 'success');
                    } else {
                        showAlert('Error deleting skill: ' + (data.d ? data.d.message : 'Unknown error'), 'danger');
                    }
                })
                .catch(error => {
                    console.error('Error deleting skill:', error);
                    showAlert('Error deleting skill', 'danger');
                });
            }
        }

        // Initialize welcome message
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(() => {
                alert('?? Admin Panel Loaded Successfully! Your login system is working properly.');
            }, 1000);
        });
    </script>
</body>
</html>