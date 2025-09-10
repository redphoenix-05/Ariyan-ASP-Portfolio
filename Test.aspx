<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="WebApplication1.Test" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Portfolio Test Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h2 class="mb-0"><i class="fas fa-rocket me-2"></i>Portfolio Website Test</h2>
                        </div>
                        <div class="card-body">
                            <h4>?? Congratulations!</h4>
                            <p class="lead">Your ASP.NET Web Forms portfolio project is now building successfully!</p>
                            
                            <h5 class="mt-4">? What's Working:</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><i class="fas fa-check text-success me-2"></i>ASP.NET Web Forms Framework</li>
                                <li class="list-group-item"><i class="fas fa-check text-success me-2"></i>Bootstrap 5 Integration</li>
                                <li class="list-group-item"><i class="fas fa-check text-success me-2"></i>Font Awesome Icons</li>
                                <li class="list-group-item"><i class="fas fa-check text-success me-2"></i>Responsive Design</li>
                                <li class="list-group-item"><i class="fas fa-check text-success me-2"></i>Project Structure</li>
                            </ul>
                            
                            <h5 class="mt-4">?? Next Steps:</h5>
                            <ol>
                                <li>Set up the SQL Server database</li>
                                <li>Configure connection strings</li>
                                <li>Enable portfolio pages</li>
                                <li>Set up admin panel</li>
                                <li>Configure email notifications</li>
                            </ol>
                            
                            <div class="mt-4">
                                <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-info d-block" 
                                          Text="This is a working ASP.NET page with server controls!" />
                                <asp:Button ID="btnTest" runat="server" Text="Test Server Interaction" 
                                           CssClass="btn btn-primary" OnClick="btnTest_Click" />
                            </div>
                            
                            <div class="mt-3">
                                <asp:Panel ID="pnlResult" runat="server" Visible="false" CssClass="alert alert-success">
                                    <strong>Success!</strong> Server-side code is working perfectly!
                                    <br />Button clicked at: <asp:Literal ID="litTime" runat="server" />
                                </asp:Panel>
                            </div>
                            
                            <div class="row mt-5">
                                <div class="col-md-6">
                                    <h5>Public Pages</h5>
                                    <ul class="list-group">
                                        <li class="list-group-item"><a href="Default.aspx" target="_blank">Homepage</a></li>
                                        <li class="list-group-item"><a href="Skills.aspx" target="_blank">Skills</a></li>
                                        <li class="list-group-item"><a href="Projects.aspx" target="_blank">Projects</a></li>
                                        <li class="list-group-item"><a href="Education.aspx" target="_blank">Education</a></li>
                                    </ul>
                                </div>
                                
                                <div class="col-md-6">
                                    <h5>Admin System</h5>
                                    <div class="alert alert-warning">
                                        <strong>New Admin Panel Available!</strong>
                                        <p>Complete CRUD operations for Skills, Projects, and Education management.</p>
                                        <a href="Admin.aspx" class="btn btn-primary" target="_blank">
                                            <i class="fas fa-cog"></i> Access Admin
                                        </a>
                                    </div>
                                    
                                    <div class="card bg-light">
                                        <div class="card-body text-center">
                                            <h6 class="card-title">Admin Login</h6>
                                            <p class="card-text">
                                                <strong>Username:</strong> admin<br />
                                                <strong>Password:</strong> 2107045
                                            </p>
                                            <a href="Admin.aspx" class="btn btn-primary" target="_blank">
                                                <i class="fas fa-sign-in-alt"></i> Login to Admin
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer text-muted">
                            <small>Portfolio project by Ariyan Rahman - Built with ASP.NET Web Forms</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>