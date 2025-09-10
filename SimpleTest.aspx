<%@ Page Title="Test" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SimpleTest.aspx.cs" Inherits="WebApplication1.SimpleTest" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style="padding: 2rem; background: white; margin: 2rem auto; max-width: 800px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        <h1 style="color: #2563EB; text-align: center; margin-bottom: 2rem;">?? Website is Working!</h1>
        
        <div style="text-align: center; margin-bottom: 2rem;">
            <h2 style="color: #14B8A6;">Content Visibility Test</h2>
            <p style="font-size: 1.2rem; color: #1F2937;">If you can see this, your website is loading properly!</p>
        </div>
        
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin: 2rem 0;">
            <div style="background: #f3f4f6; padding: 1rem; border-radius: 8px; text-align: center;">
                <i class="fas fa-check-circle" style="font-size: 2rem; color: #10b981; margin-bottom: 0.5rem;"></i>
                <h4 style="margin: 0.5rem 0;">Navigation</h4>
                <p style="margin: 0; color: #6b7280;">Working ?</p>
            </div>
            
            <div style="background: #f3f4f6; padding: 1rem; border-radius: 8px; text-align: center;">
                <i class="fas fa-palette" style="font-size: 2rem; color: #3b82f6; margin-bottom: 0.5rem;"></i>
                <h4 style="margin: 0.5rem 0;">Styling</h4>
                <p style="margin: 0; color: #6b7280;">Applied ?</p>
            </div>
            
            <div style="background: #f3f4f6; padding: 1rem; border-radius: 8px; text-align: center;">
                <i class="fas fa-bolt" style="font-size: 2rem; color: #f59e0b; margin-bottom: 0.5rem;"></i>
                <h4 style="margin: 0.5rem 0;">Performance</h4>
                <p style="margin: 0; color: #6b7280;">Fast ?</p>
            </div>
        </div>
        
        <div style="text-align: center; margin-top: 2rem; padding: 1rem; background: linear-gradient(135deg, #2563EB 0%, #14B8A6 100%); color: white; border-radius: 8px;">
            <h3 style="margin: 0 0 1rem 0;">Next Steps</h3>
            <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                <a href="Default.aspx" style="background: rgba(255,255,255,0.2); color: white; padding: 0.5rem 1rem; border-radius: 5px; text-decoration: none; display: inline-block;">?? Home Page</a>
                <a href="About.aspx" style="background: rgba(255,255,255,0.2); color: white; padding: 0.5rem 1rem; border-radius: 5px; text-decoration: none; display: inline-block;">?? About</a>
                <a href="Skills.aspx" style="background: rgba(255,255,255,0.2); color: white; padding: 0.5rem 1rem; border-radius: 5px; text-decoration: none; display: inline-block;">??? Skills</a>
                <a href="Projects.aspx" style="background: rgba(255,255,255,0.2); color: white; padding: 0.5rem 1rem; border-radius: 5px; text-decoration: none; display: inline-block;">?? Projects</a>
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('? SimpleTest page loaded successfully!');
            console.log('? Content is visible');
            console.log('? JavaScript is working');
            console.log('? Ready to test other pages');
        });
    </script>
</asp:Content>