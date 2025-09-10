<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SkillsTest.aspx.cs" Inherits="WebApplication1.SkillsTest" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Skills Test Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
        }
        
        .test-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            margin: 20px auto;
            max-width: 1200px;
            overflow: hidden;
        }
        
        .test-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px;
            text-align: center;
        }
        
        .skill-card {
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .skill-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        .skill-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .progress {
            height: 12px;
            background-color: #e9ecef;
            border-radius: 6px;
        }
        
        .progress-bar {
            transition: width 2s ease-in-out;
            border-radius: 6px;
            background: linear-gradient(45deg, #667eea, #764ba2);
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="test-container">
                <div class="test-header">
                    <h1><i class="fas fa-cogs me-2"></i>Skills Test Page</h1>
                    <p class="mb-0">Testing Skills Database Integration</p>
                </div>

                <div class="container p-4">
                    
                    <!-- Status -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="alert alert-info">
                                <h5><i class="fas fa-info-circle me-2"></i>Status</h5>
                                <div id="statusMessage">Loading skills...</div>
                            </div>
                        </div>
                    </div>

                    <!-- Skills Container -->
                    <div class="skills-container">
                        <div class="row">
                            <!-- Skills will be loaded here -->
                            <div class="col-12 text-center py-5">
                                <div class="spinner-border text-primary" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                                <p class="mt-3 text-muted">Loading skills from database...</p>
                            </div>
                        </div>
                    </div>

                    <!-- Navigation -->
                    <div class="text-center mt-4">
                        <a href="WorkingAdmin.aspx" class="btn btn-outline-primary me-2">
                            <i class="fas fa-database me-1"></i>Admin Panel
                        </a>
                        <a href="Default.aspx" class="btn btn-outline-secondary me-2">
                            <i class="fas fa-home me-1"></i>Home
                        </a>
                        <a href="Skills.aspx" class="btn btn-primary">
                            <i class="fas fa-cogs me-1"></i>Full Skills Page
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>