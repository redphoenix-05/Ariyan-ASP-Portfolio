<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SimpleLogin.aspx.cs" Inherits="WebApplication1.SimpleLogin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Simple Login Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .login-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            padding: 2rem;
            max-width: 400px;
            width: 100%;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-card">
            <form id="form1" runat="server">
                <h3 class="text-center mb-4">?? Simple Login Test</h3>
                
                <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert">
                    <asp:Literal ID="litMessage" runat="server" />
                </asp:Panel>
                
                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Text="Ariyan" />
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Text="Ariyan123" />
                </div>
                
                <div class="d-grid gap-2">
                    <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary btn-lg" 
                        Text="Simple Login Test" OnClick="btnLogin_Click" />
                    
                    <asp:Button ID="btnDirectRedirect" runat="server" CssClass="btn btn-success" 
                        Text="Direct Redirect to Admin" OnClick="btnDirectRedirect_Click" />
                </div>
                
                <div class="mt-3 text-center">
                    <small class="text-muted">
                        This is a simplified test to check redirect functionality.
                    </small>
                </div>
            </form>
        </div>
    </div>
</body>
</html>