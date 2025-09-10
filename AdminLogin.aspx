<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="WebApplication1.AdminLogin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #2563EB, #14B8A6);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-box {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            max-width: 400px;
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-box">
            <h2 class="text-center mb-4">Admin Login</h2>
            
            <div class="alert alert-info">
                <strong>Login:</strong> admin<br>
                <strong>Password:</strong> 2107045
            </div>
            
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert">
                <asp:Literal ID="litMessage" runat="server" />
            </asp:Panel>
            
            <div class="mb-3">
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username" />
            </div>
            
            <div class="mb-3">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password" />
            </div>
            
            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary w-100" Text="Login" OnClick="btnLogin_Click" />
            
            <div class="text-center mt-3">
                <a href="Default.aspx">? Back to Portfolio</a>
            </div>
        </div>
    </form>
</body>
</html>