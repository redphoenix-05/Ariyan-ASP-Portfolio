<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RedirectTest.aspx.cs" Inherits="WebApplication1.RedirectTest" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Redirect Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .test-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            padding: 2rem;
            max-width: 600px;
            width: 100%;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="test-container text-center">
            <form id="form1" runat="server">
                <h2 class="mb-4">?? Redirect Test Page</h2>
                
                <div class="alert alert-info">
                    <h5>Test Basic Redirect Functionality</h5>
                    <p>Click the buttons below to test different redirect methods:</p>
                </div>

                <div class="d-grid gap-3">
                    <asp:Button ID="btnRedirectToAdminTest" runat="server" 
                        CssClass="btn btn-primary btn-lg" 
                        Text="Test Redirect to AdminTest.aspx" 
                        OnClick="btnRedirectToAdminTest_Click" />
                    
                    <asp:Button ID="btnRedirectToAdmin" runat="server" 
                        CssClass="btn btn-success btn-lg" 
                        Text="Test Redirect to Admin.aspx" 
                        OnClick="btnRedirectToAdmin_Click" />
                    
                    <button type="button" class="btn btn-info btn-lg" onclick="testJavaScriptRedirect()">
                        Test JavaScript Redirect
                    </button>
                    
                    <a href="AdminTest.aspx" class="btn btn-warning btn-lg">
                        Direct Link to AdminTest.aspx
                    </a>
                </div>

                <div class="mt-4">
                    <small class="text-muted">
                        If any of these work, we'll know the redirect mechanism is functional.
                    </small>
                </div>

                <!-- Debug Info -->
                <div class="mt-4 text-start">
                    <h6>Debug Information:</h6>
                    <ul class="list-unstyled small">
                        <li><strong>Current URL:</strong> <span id="currentUrl"></span></li>
                        <li><strong>User Agent:</strong> <span id="userAgent"></span></li>
                        <li><strong>Session Available:</strong> <asp:Literal ID="litSessionInfo" runat="server" /></li>
                    </ul>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('currentUrl').textContent = window.location.href;
            document.getElementById('userAgent').textContent = navigator.userAgent.substring(0, 50) + '...';
        });

        function testJavaScriptRedirect() {
            alert('Testing JavaScript redirect in 2 seconds...');
            setTimeout(() => {
                window.location.href = 'AdminTest.aspx';
            }, 2000);
        }
    </script>
</body>
</html>