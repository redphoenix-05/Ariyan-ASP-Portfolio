<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkingAdmin.aspx.cs" Inherits="WebApplication1.WorkingAdmin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Portfolio Admin - Database Management</title>
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
            max-width: 1400px;
            overflow: hidden;
        }
        .admin-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px;
            text-align: center;
        }
        .crud-section {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .section-header {
            background: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #dee2e6;
            font-weight: bold;
        }
        .section-content {
            padding: 20px;
        }
        .hidden { display: none; }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="admin-container">
                <div class="admin-header">
                    <h1><i class="fas fa-database me-2"></i>Portfolio Admin Panel</h1>
                    <p class="mb-0">Simple Database Management Interface</p>
                </div>

                <div class="container-fluid p-4">
                    
                    <!-- Database Status -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="alert alert-info">
                                <h5><i class="fas fa-info-circle me-2"></i>Database Status</h5>
                                <div id="dbStatus">Testing connection...</div>
                            </div>
                        </div>
                    </div>

                    <!-- Test Database Operations -->
                    <div class="crud-section">
                        <div class="section-header">
                            <i class="fas fa-vial me-2"></i>Database Operations Test
                        </div>
                        <div class="section-content">
                            <div class="row">
                                <div class="col-md-6">
                                    <button type="button" class="btn btn-primary me-2" onclick="testConnection()">
                                        <i class="fas fa-plug me-1"></i>Test Connection
                                    </button>
                                    <button type="button" class="btn btn-success me-2" onclick="createSampleData()">
                                        <i class="fas fa-plus me-1"></i>Create Sample Data
                                    </button>
                                    <button type="button" class="btn btn-info" onclick="viewData()">
                                        <i class="fas fa-eye me-1"></i>View Data
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <div id="operationResult" class="alert alert-secondary">
                                        Click buttons above to test database operations
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Skills Management -->
                    <div class="crud-section">
                        <div class="section-header">
                            <i class="fas fa-cogs me-2"></i>Skills Management (Direct SQL)
                        </div>
                        <div class="section-content">
                            <div class="alert alert-warning">
                                <h6><i class="fas fa-exclamation-triangle me-2"></i>Direct Database Access</h6>
                                <p class="mb-2">For complete CRUD operations, use SQL Server Management Studio:</p>
                                <ol class="mb-0">
                                    <li>Connect to: <strong>DESKTOP-FST3V7D\SQLEXPRESS</strong></li>
                                    <li>Database: <strong>PortfolioDatabase</strong></li>
                                    <li>Edit tables: <strong>Skills, Projects, Education, Achievements</strong></li>
                                </ol>
                            </div>
                            
                            <div id="skillsData" class="mt-3">
                                <h6>Current Skills:</h6>
                                <div class="table-responsive">
                                    <table class="table table-sm" id="skillsTable">
                                        <thead>
                                            <tr>
                                                <th>Skill</th>
                                                <th>Category</th>
                                                <th>Proficiency</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody id="skillsTableBody">
                                            <tr><td colspan="4" class="text-center">Loading...</td></tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Projects Management -->
                    <div class="crud-section">
                        <div class="section-header">
                            <i class="fas fa-folder-open me-2"></i>Projects Management
                        </div>
                        <div class="section-content">
                            <div id="projectsData">
                                <h6>Current Projects:</h6>
                                <div class="table-responsive">
                                    <table class="table table-sm" id="projectsTable">
                                        <thead>
                                            <tr>
                                                <th>Title</th>
                                                <th>Type</th>
                                                <th>Status</th>
                                                <th>Featured</th>
                                            </tr>
                                        </thead>
                                        <tbody id="projectsTableBody">
                                            <tr><td colspan="4" class="text-center">Loading...</td></tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Links -->
                    <div class="text-center">
                        <a href="Default.aspx" class="btn btn-outline-primary me-2" target="_blank">
                            <i class="fas fa-eye me-1"></i>View Portfolio
                        </a>
                        <a href="DatabaseTest.aspx" class="btn btn-outline-info me-2" target="_blank">
                            <i class="fas fa-database me-1"></i>Database Test
                        </a>
                        <a href="Test.aspx" class="btn btn-outline-secondary" target="_blank">
                            <i class="fas fa-vial me-1"></i>Test Page
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            testConnection();
            loadSkillsData();
            loadProjectsData();
        });

        function testConnection() {
            updateStatus('Testing database connection...', 'info');
            
            fetch('WorkingAdmin.aspx/TestConnection', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({})
            })
            .then(response => response.json())
            .then(data => {
                if (data.d && data.d.success) {
                    updateDbStatus(data.d.message, 'success');
                } else {
                    updateDbStatus(data.d ? data.d.message : 'Connection failed', 'danger');
                }
            })
            .catch(error => {
                updateDbStatus('Connection error: ' + error.message, 'danger');
            });
        }

        function createSampleData() {
            updateStatus('Creating sample data...', 'info');
            
            fetch('WorkingAdmin.aspx/CreateSampleData', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({})
            })
            .then(response => response.json())
            .then(data => {
                if (data.d && data.d.success) {
                    updateStatus(data.d.message, 'success');
                    loadSkillsData();
                    loadProjectsData();
                } else {
                    updateStatus(data.d ? data.d.message : 'Operation failed', 'danger');
                }
            })
            .catch(error => {
                updateStatus('Error: ' + error.message, 'danger');
            });
        }

        function viewData() {
            loadSkillsData();
            loadProjectsData();
            updateStatus('Data refreshed successfully', 'success');
        }

        function loadSkillsData() {
            fetch('WorkingAdmin.aspx/GetSkills', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({})
            })
            .then(response => response.json())
            .then(data => {
                if (data.d && data.d.success) {
                    displaySkills(data.d.data);
                } else {
                    document.getElementById('skillsTableBody').innerHTML = 
                        '<tr><td colspan="4" class="text-center text-muted">No skills found or error loading data</td></tr>';
                }
            })
            .catch(error => {
                document.getElementById('skillsTableBody').innerHTML = 
                    '<tr><td colspan="4" class="text-center text-danger">Error: ' + error.message + '</td></tr>';
            });
        }

        function loadProjectsData() {
            fetch('WorkingAdmin.aspx/GetProjects', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({})
            })
            .then(response => response.json())
            .then(data => {
                if (data.d && data.d.success) {
                    displayProjects(data.d.data);
                } else {
                    document.getElementById('projectsTableBody').innerHTML = 
                        '<tr><td colspan="4" class="text-center text-muted">No projects found or error loading data</td></tr>';
                }
            })
            .catch(error => {
                document.getElementById('projectsTableBody').innerHTML = 
                    '<tr><td colspan="4" class="text-center text-danger">Error: ' + error.message + '</td></tr>';
            });
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
                                <div class="progress-bar" role="progressbar" style="width: ${skill.ProficiencyLevel}%">
                                    ${skill.ProficiencyLevel}%
                                </div>
                            </div>
                        </td>
                        <td><span class="badge bg-success">Active</span></td>
                    </tr>
                `).join('');
            } else {
                tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted">No skills found</td></tr>';
            }
        }

        function displayProjects(projects) {
            const tbody = document.getElementById('projectsTableBody');
            if (projects && projects.length > 0) {
                tbody.innerHTML = projects.map(project => `
                    <tr>
                        <td><strong>${project.Title}</strong></td>
                        <td><span class="badge bg-info">${project.ProjectType}</span></td>
                        <td><span class="badge bg-success">${project.Status}</span></td>
                        <td>${project.IsFeatured ? '<i class="fas fa-star text-warning"></i>' : '<i class="far fa-star text-muted"></i>'}</td>
                    </tr>
                `).join('');
            } else {
                tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted">No projects found</td></tr>';
            }
        }

        function updateDbStatus(message, type) {
            const icons = {
                'success': 'fas fa-check-circle text-success',
                'danger': 'fas fa-exclamation-triangle text-danger',
                'info': 'fas fa-info-circle text-info'
            };
            
            document.getElementById('dbStatus').innerHTML = 
                `<i class="${icons[type]} me-2"></i>${message}`;
        }

        function updateStatus(message, type) {
            const element = document.getElementById('operationResult');
            element.className = `alert alert-${type}`;
            element.innerHTML = `<i class="fas fa-info-circle me-2"></i>${message}`;
        }
    </script>
</body>
</html>