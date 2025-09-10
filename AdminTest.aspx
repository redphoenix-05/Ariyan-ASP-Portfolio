<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminTest.aspx.cs" Inherits="WebApplication1.AdminTest" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Test - Login Successful</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }
        .test-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
        }
        .test-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            padding: 2rem;
        }
        .success-icon {
            font-size: 4rem;
            color: #28a745;
            animation: bounce 2s infinite;
        }
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }
    </style>
</head>
<body>
    <div class="container test-container">
        <div class="card test-card text-center">
            <div class="card-body">
                <div class="success-icon mb-4">
                    <i class="fas fa-check-circle"></i>
                </div>
                
                <h1 class="card-title text-success mb-4">?? Login Redirect Test Successful!</h1>
                
                <div class="alert alert-success">
                    <h5><i class="fas fa-user-shield me-2"></i>Authentication Working</h5>
                    <p>You have successfully logged in! Redirecting to main admin panel in 3 seconds...</p>
                </div>
                
                <div class="row text-start">
                    <div class="col-md-6">
                        <h6><i class="fas fa-info-circle me-2"></i>Session Information:</h6>
                        <ul class="list-unstyled">
                            <li><strong>Username:</strong> <asp:Literal ID="litUsername" runat="server" /></li>
                            <li><strong>User ID:</strong> <asp:Literal ID="litUserId" runat="server" /></li>
                            <li><strong>Full Name:</strong> <asp:Literal ID="litFullName" runat="server" /></li>
                            <li><strong>Login Time:</strong> <asp:Literal ID="litLoginTime" runat="server" /></li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h6><i class="fas fa-cog me-2"></i>Authentication Status:</h6>
                        <ul class="list-unstyled">
                            <li><strong>Session Valid:</strong> <asp:Literal ID="litSessionValid" runat="server" /></li>
                            <li><strong>Forms Auth:</strong> <asp:Literal ID="litFormsAuth" runat="server" /></li>
                            <li><strong>Session ID:</strong> <asp:Literal ID="litSessionId" runat="server" /></li>
                        </ul>
                    </div>
                </div>
                
                <div class="mt-4">
                    <a href="Admin.aspx" class="btn btn-primary btn-lg me-3">
                        <i class="fas fa-tachometer-alt me-2"></i>Go to Full Admin Panel
                    </a>
                    <a href="AdminLogin.aspx" class="btn btn-outline-secondary">
                        <i class="fas fa-sign-out-alt me-2"></i>Logout & Return to Login
                    </a>
                </div>
                
                <div class="mt-4">
                    <small class="text-muted">
                        <i class="fas fa-check me-1"></i>
                        If you can see this page, your admin login redirect is working correctly!
                    </small>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>