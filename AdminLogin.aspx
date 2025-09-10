<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="WebApplication1.AdminLogin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Portfolio Admin - Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            max-width: 450px;
            width: 100%;
            margin: 0 auto;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-header h2 {
            color: #333;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .login-header p {
            color: #666;
            margin-bottom: 0;
        }

        .form-floating {
            margin-bottom: 1.5rem;
        }

        .form-floating .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 1rem 0.75rem;
            transition: all 0.3s ease;
        }

        .form-floating .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        .btn-login {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            border-radius: 12px;
            padding: 0.8rem 2rem;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .alert {
            border-radius: 12px;
            border: none;
            margin-bottom: 1.5rem;
        }

        .admin-icon {
            font-size: 4rem;
            color: #667eea;
            margin-bottom: 1rem;
        }

        .login-links {
            text-align: center;
            margin-top: 2rem;
        }

        .login-links a {
            color: #667eea;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .login-links a:hover {
            color: #764ba2;
        }

        .security-info {
            background: rgba(102, 126, 234, 0.1);
            border-radius: 12px;
            padding: 1rem;
            margin-top: 1.5rem;
            text-align: center;
        }

        .security-info small {
            color: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        @media (max-width: 576px) {
            .login-container {
                margin: 1rem;
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="login-container">
            <form id="form1" runat="server">
                <div class="login-header">
                    <div class="admin-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h2>Admin Login</h2>
                    <p>Access your portfolio management system</p>
                </div>

                <!-- Alert Messages -->
                <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                    <div id="alertMessage" class="alert" role="alert">
                        <asp:Literal ID="litMessage" runat="server" />
                    </div>
                </asp:Panel>

                <!-- Login Form -->
                <div class="form-floating">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username" MaxLength="50" />
                    <label for="txtUsername">
                        <i class="fas fa-user me-2"></i>Username
                    </label>
                </div>

                <div class="form-floating">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password" MaxLength="100" />
                    <label for="txtPassword">
                        <i class="fas fa-lock me-2"></i>Password
                    </label>
                </div>

                <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary btn-login" 
                    Text="Sign In" OnClick="btnLogin_Click" UseSubmitBehavior="true" />

                <div class="security-info">
                    <small>
                        <i class="fas fa-shield-alt text-success"></i>
                        Secure admin access with encrypted credentials
                    </small>
                </div>

                <div class="login-links">
                    <a href="Default.aspx">
                        <i class="fas fa-home me-1"></i>Back to Portfolio
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alert = document.querySelector('.alert');
            if (alert && alert.classList.contains('alert-danger')) {
                setTimeout(() => {
                    alert.style.opacity = '0';
                    setTimeout(() => alert.style.display = 'none', 300);
                }, 5000);
            }
        });
    </script>
</body>
</html>