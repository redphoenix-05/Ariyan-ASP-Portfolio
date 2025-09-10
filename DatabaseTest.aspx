<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DatabaseTest.aspx.cs" Inherits="WebApplication1.DatabaseTest" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Database Connection Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .test-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="test-container">
            <h1 class="text-center mb-4">Database Connection Test</h1>
            
            <div class="row">
                <div class="col-md-6">
                    <h5>Connection Information</h5>
                    <ul class="list-group mb-3">
                        <li class="list-group-item">
                            <strong>Server:</strong> <span id="serverName">DESKTOP-FST3V7D\SQLEXPRESS</span>
                        </li>
                        <li class="list-group-item">
                            <strong>Database:</strong> <span id="databaseName">PortfolioDatabase</span>
                        </li>
                        <li class="list-group-item">
                            <strong>Authentication:</strong> <span id="authType">Windows Authentication</span>
                        </li>
                    </ul>
                </div>
                
                <div class="col-md-6">
                    <h5>Test Results</h5>
                    <div id="testResults">
                        <asp:Panel ID="pnlResults" runat="server">
                            <asp:Literal ID="litResults" runat="server" />
                        </asp:Panel>
                    </div>
                </div>
            </div>
            
            <div class="text-center">
                <asp:Button ID="btnTestConnection" runat="server" CssClass="btn btn-primary btn-lg" 
                    Text="Test Database Connection" OnClick="btnTestConnection_Click" />
                <asp:Button ID="btnTestTables" runat="server" CssClass="btn btn-info btn-lg ms-2" 
                    Text="Test Tables" OnClick="btnTestTables_Click" />
                <asp:Button ID="btnCreateSampleData" runat="server" CssClass="btn btn-success btn-lg ms-2" 
                    Text="Create Sample Data" OnClick="btnCreateSampleData_Click" />
            </div>
            
            <div class="mt-4">
                <h5>Database Setup Instructions</h5>
                <div class="alert alert-info">
                    <ol>
                        <li>Open <strong>SQL Server Management Studio</strong></li>
                        <li>Connect to <strong>DESKTOP-FST3V7D\SQLEXPRESS</strong></li>
                        <li>Create database <strong>PortfolioDatabase</strong> if it doesn't exist</li>
                        <li>Run the table creation scripts provided</li>
                        <li>Click "Create Sample Data" to populate tables</li>
                    </ol>
                </div>
            </div>
            
            <div class="text-center mt-3">
                <a href="Default.aspx" class="btn btn-outline-secondary">Back to Portfolio</a>
                <a href="SimpleAdmin.aspx" class="btn btn-outline-primary">Admin Panel</a>
            </div>
        </div>
    </form>
</body>
</html>