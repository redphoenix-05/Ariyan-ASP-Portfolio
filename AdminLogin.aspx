<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="WebApplication1.AdminLogin" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Login - Portfolio</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-container {
            max-width: 400px;
            width: 100%;
            margin: 20px;
        }
        
        .login-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .login-header {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .login-header i {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .login-body {
            padding: 2rem;
        }
        
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #28a745;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
        }
        
        .btn-login {
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .back-link {
            text-align: center;
            margin-top: 1rem;
        }
        
        .back-link a {
            color: #6c757d;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        
        .back-link a:hover {
            color: #28a745;
        }
        
        .alert {
            border-radius: 10px;
            border: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="card login-card">
                <div class="login-header">
                    <i class="fas fa-shield-alt"></i>
                    <h3 class="mb-0">Admin Login</h3>
                    <p class="mb-0">Portfolio Management System</p>
                </div>
                
                <div class="login-body">
                    <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="mb-4">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <asp:Literal ID="litError" runat="server" />
                        </div>
                    </asp:Panel>
                    
                    <div class="mb-3">
                        <label for="<%= txtUsername.ClientID %>" class="form-label">
                            <i class="fas fa-user me-2"></i>Username
                        </label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" 
                                    placeholder="Enter your username" />
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                                                  ControlToValidate="txtUsername" 
                                                  ErrorMessage="Username is required"
                                                  CssClass="text-danger small"
                                                  Display="Dynamic" />
                    </div>
                    
                    <div class="mb-4">
                        <label for="<%= txtPassword.ClientID %>" class="form-label">
                            <i class="fas fa-lock me-2"></i>Password
                        </label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" 
                                    TextMode="Password" placeholder="Enter your password" />
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                                                  ControlToValidate="txtPassword" 
                                                  ErrorMessage="Password is required"
                                                  CssClass="text-danger small"
                                                  Display="Dynamic" />
                    </div>
                    
                    <div class="d-grid mb-3">
                        <asp:Button ID="btnLogin" runat="server" Text="Login" 
                                   CssClass="btn btn-success btn-login"
                                   OnClick="btnLogin_Click" />
                    </div>
                    
                    <div class="back-link">
                        <a href="Default.aspx">
                            <i class="fas fa-arrow-left me-1"></i>
                            Back to Portfolio
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Security Notice -->
            <div class="text-center mt-4">
                <small class="text-white-50">
                    <i class="fas fa-info-circle me-1"></i>
                    This is a secure area. All access attempts are logged.
                </small>
            </div>
        </div>
    </form>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Focus on username field
            document.getElementById('<%= txtUsername.ClientID %>').focus();
            
            // Add loading state to login button
            const form = document.getElementById('form1');
            const loginBtn = document.getElementById('<%= btnLogin.ClientID %>');
            
            form.addEventListener('submit', function(e) {
                if (this.checkValidity && this.checkValidity()) {
                    loginBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Authenticating...';
                    loginBtn.disabled = true;
                }
            });
            
            // Auto-hide error messages
            const errorPanel = document.querySelector('.alert-danger');
            if (errorPanel) {
                setTimeout(() => {
                    errorPanel.style.transition = 'opacity 0.5s ease';
                    errorPanel.style.opacity = '0';
                    setTimeout(() => errorPanel.remove(), 500);
                }, 5000);
            }
        });
    </script>
</body>
</html>