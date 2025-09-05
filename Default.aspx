<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1.Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Welcome to my personal portfolio. I'm a passionate software developer specializing in web development." />
    <meta name="keywords" content="portfolio, web developer, software engineer, programming" />
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="hero-content">
                        <h1 class="display-4 fw-bold">
                            <asp:Literal ID="litFullName" runat="server" Text="Ariyan Rahman" />
                        </h1>
                        <p class="lead">
                            <asp:Literal ID="litTagline" runat="server" Text="Full Stack Developer | ASP.NET Specialist" />
                        </p>
                        <div class="hero-buttons">
                            <a href="About.aspx" class="btn btn-light btn-lg btn-custom me-3">
                                <i class="fas fa-user me-2"></i>About Me
                            </a>
                            <a href="Contact.aspx" class="btn btn-outline-light btn-lg btn-custom">
                                <i class="fas fa-envelope me-2"></i>Get In Touch
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <asp:Image ID="imgProfile" runat="server" CssClass="profile-img img-fluid" 
                              ImageUrl="~/Images/profile-placeholder.jpg" AlternateText="Profile Photo" />
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Stats Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-3 mb-4">
                    <div class="stats-card">
                        <h3 data-count="5">5</h3>
                        <p class="mb-0">Projects Completed</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stats-card bg-success">
                        <h3 data-count="12">12</h3>
                        <p class="mb-0">Skills Mastered</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stats-card bg-warning text-dark">
                        <h3 data-count="3">3</h3>
                        <p class="mb-0">Achievements</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stats-card bg-info">
                        <h3 data-count="7">7</h3>
                        <p class="mb-0">Certifications</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Skills Section -->
    <section class="py-5">
        <div class="container">
            <h2 class="section-title">Core Skills</h2>
            <div class="row">
                <!-- Sample Skills for now -->
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100 text-center">
                        <div class="card-body">
                            <i class="fab fa-microsoft fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">C# / ASP.NET</h5>
                            <div class="progress mt-3">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 90%" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100">
                                    90%
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100 text-center">
                        <div class="card-body">
                            <i class="fas fa-database fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">SQL Server</h5>
                            <div class="progress mt-3">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 80%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100">
                                    80%
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100 text-center">
                        <div class="card-body">
                            <i class="fab fa-js-square fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">JavaScript</h5>
                            <div class="progress mt-3">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
                                    75%
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <a href="Skills.aspx" class="btn btn-primary btn-custom">
                    <i class="fas fa-cogs me-2"></i>View All Skills
                </a>
            </div>
        </div>
    </section>

    <!-- Featured Projects Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <h2 class="section-title">Featured Projects</h2>
            <div class="row">
                <!-- Sample Project for now -->
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100">
                        <img src="~/Images/project-placeholder.jpg" class="card-img-top" alt="Portfolio Website" />
                        <div class="card-body">
                            <h5 class="card-title">Portfolio Website</h5>
                            <p class="card-text">A responsive personal portfolio website built with ASP.NET Web Forms, featuring admin panel and contact system.</p>
                            <div class="mb-2">
                                <small class="text-muted">
                                    <strong>Tech Stack:</strong> ASP.NET Web Forms, C#, SQL Server, Bootstrap
                                </small>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="https://github.com/redphoenix-05/Ariyan-ASP-Portfolio" class="btn btn-outline-dark btn-sm" target="_blank">
                                    <i class="fab fa-github me-1"></i>Code
                                </a>
                                <a href="#" class="btn btn-primary btn-sm">
                                    <i class="fas fa-external-link-alt me-1"></i>Demo
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <a href="Projects.aspx" class="btn btn-primary btn-custom">
                    <i class="fas fa-folder-open me-2"></i>View All Projects
                </a>
            </div>
        </div>
    </section>

    <!-- Call to Action Section -->
    <section class="py-5 bg-primary text-white">
        <div class="container text-center">
            <h2 class="h1 mb-4">Let's Work Together!</h2>
            <p class="lead mb-4">Ready to bring your ideas to life? I'm available for freelance projects and full-time opportunities.</p>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="d-flex flex-wrap justify-content-center gap-3">
                        <a href="Contact.aspx" class="btn btn-light btn-lg btn-custom">
                            <i class="fas fa-paper-plane me-2"></i>Send Message
                        </a>
                        <a href="~/Documents/Resume.pdf" class="btn btn-outline-light btn-lg btn-custom" target="_blank">
                            <i class="fas fa-download me-2"></i>Download Resume
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate counters when they come into view
            const statsCards = document.querySelectorAll('.stats-card h3[data-count]');
            
            const animateCounter = (element) => {
                const target = parseInt(element.getAttribute('data-count'));
                if (target > 0) {
                    const duration = 2000; // 2 seconds
                    const start = performance.now();
                    
                    const updateCounter = (currentTime) => {
                        const elapsed = currentTime - start;
                        const progress = Math.min(elapsed / duration, 1);
                        const current = Math.floor(progress * target);
                        
                        element.textContent = current;
                        
                        if (progress < 1) {
                            requestAnimationFrame(updateCounter);
                        } else {
                            element.textContent = target;
                        }
                    };
                    
                    requestAnimationFrame(updateCounter);
                }
            };
            
            // Intersection Observer for counter animation
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        animateCounter(entry.target);
                        observer.unobserve(entry.target); // Only animate once
                    }
                });
            });
            
            statsCards.forEach(card => observer.observe(card));
        });
    </script>
</asp:Content>