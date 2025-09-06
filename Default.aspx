<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1.Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Welcome to Ariyan Aftab Spandan's portfolio. App Developer specializing in mobile and web applications." />
    <meta name="keywords" content="portfolio, app developer, mobile developer, web developer, Ariyan Aftab Spandan" />
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="hero-content fade-in">
                        <h1 class="display-4 fw-bold">
                            <asp:Literal ID="litFullName" runat="server" Text="Ariyan Aftab Spandan" />
                        </h1>
                        <p class="lead">
                            <asp:Literal ID="litTagline" runat="server" Text="App Developer | Mobile & Web Specialist" />
                        </p>
                        <p class="hero-description">
                            Creating innovative mobile and web applications with cutting-edge technology. 
                            Passionate about building user-friendly solutions that make a difference.
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
                    <div class="slide-up">
                        <asp:Image ID="imgProfile" runat="server" CssClass="profile-img img-fluid" 
                                  ImageUrl="~/Images/profile/profile.jpg" AlternateText="Ariyan Aftab Spandan" />
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Stats Section -->
    <section class="py-5 stats-section">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="8">8</h3>
                        <p class="stat-label">Apps Developed</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="15">15</h3>
                        <p class="stat-label">Technologies</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="5">5</h3>
                        <p class="stat-label">Achievements</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="12">12</h3>
                        <p class="stat-label">Certifications</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Skills Section -->
    <section class="py-5 skills-section">
        <div class="container">
            <h2 class="section-title">Core Technologies</h2>
            <div class="row">
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100 text-center">
                        <div class="card-body">
                            <i class="fab fa-android fa-3x text-success mb-3"></i>
                            <h5 class="card-title">Android Development</h5>
                            <div class="progress mt-3">
                                <div class="progress-bar" role="progressbar" style="width: 90%" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100">
                                    90%
                                </div>
                            </div>
                            <p class="card-text mt-2"><small class="text-muted">Java, Kotlin, Android Studio</small></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100 text-center">
                        <div class="card-body">
                            <i class="fab fa-apple fa-3x text-secondary mb-3"></i>
                            <h5 class="card-title">iOS Development</h5>
                            <div class="progress mt-3">
                                <div class="progress-bar" role="progressbar" style="width: 85%" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100">
                                    85%
                                </div>
                            </div>
                            <p class="card-text mt-2"><small class="text-muted">Swift, SwiftUI, Xcode</small></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100 text-center">
                        <div class="card-body">
                            <i class="fab fa-react fa-3x text-info mb-3"></i>
                            <h5 class="card-title">React Native</h5>
                            <div class="progress mt-3">
                                <div class="progress-bar" role="progressbar" style="width: 80%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100">
                                    80%
                                </div>
                            </div>
                            <p class="card-text mt-2"><small class="text-muted">Cross-platform mobile apps</small></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100 text-center">
                        <div class="card-body">
                            <i class="fab fa-microsoft fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">ASP.NET</h5>
                            <div class="progress mt-3">
                                <div class="progress-bar" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
                                    75%
                                </div>
                            </div>
                            <p class="card-text mt-2"><small class="text-muted">Web Forms, MVC, Core</small></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100 text-center">
                        <div class="card-body">
                            <i class="fas fa-database fa-3x text-warning mb-3"></i>
                            <h5 class="card-title">Database Design</h5>
                            <div class="progress mt-3">
                                <div class="progress-bar" role="progressbar" style="width: 85%" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100">
                                    85%
                                </div>
                            </div>
                            <p class="card-text mt-2"><small class="text-muted">SQL Server, SQLite, Firebase</small></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100 text-center">
                        <div class="card-body">
                            <i class="fas fa-cloud fa-3x text-info mb-3"></i>
                            <h5 class="card-title">Cloud Services</h5>
                            <div class="progress mt-3">
                                <div class="progress-bar" role="progressbar" style="width: 70%" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100">
                                    70%
                                </div>
                            </div>
                            <p class="card-text mt-2"><small class="text-muted">Azure, AWS, Firebase</small></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <a href="About.aspx" class="btn btn-primary btn-custom">
                    <i class="fas fa-cogs me-2"></i>View All Skills
                </a>
            </div>
        </div>
    </section>

    <!-- Featured Projects Section -->
    <section class="py-5 services-section">
        <div class="container">
            <h2 class="section-title">Featured Projects</h2>
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100">
                        <img src="~/Images/projects/project1.jpg" class="card-img-top" alt="Portfolio Mobile App" 
                             onerror="this.src='https://via.placeholder.com/400x250/007bff/ffffff?text=Portfolio+App'">
                        <div class="card-body">
                            <h5 class="card-title">Portfolio Mobile App</h5>
                            <p class="card-text">A cross-platform mobile application showcasing my portfolio with interactive features and smooth animations.</p>
                            <div class="mb-2">
                                <small class="text-muted">
                                    <strong>Tech Stack:</strong> React Native, Firebase, Redux
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
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100">
                        <img src="~/Images/projects/project2.jpg" class="card-img-top" alt="E-Commerce App" 
                             onerror="this.src='https://via.placeholder.com/400x250/28a745/ffffff?text=E-Commerce+App'">
                        <div class="card-body">
                            <h5 class="card-title">E-Commerce Mobile App</h5>
                            <p class="card-text">Full-featured shopping app with payment integration, user authentication, and real-time order tracking.</p>
                            <div class="mb-2">
                                <small class="text-muted">
                                    <strong>Tech Stack:</strong> Flutter, Node.js, MongoDB
                                </small>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-dark btn-sm disabled">
                                    <i class="fab fa-github me-1"></i>Private
                                </a>
                                <a href="#" class="btn btn-primary btn-sm disabled">
                                    <i class="fas fa-external-link-alt me-1"></i>Demo
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100">
                        <img src="~/Images/projects/project3.jpg" class="card-img-top" alt="Task Manager Web App" 
                             onerror="this.src='https://via.placeholder.com/400x250/dc3545/ffffff?text=Task+Manager'">
                        <div class="card-body">
                            <h5 class="card-title">Task Manager Web App</h5>
                            <p class="card-text">Productivity application with team collaboration features, real-time updates, and progress tracking.</p>
                            <div class="mb-2">
                                <small class="text-muted">
                                    <strong>Tech Stack:</strong> ASP.NET Core, SignalR, SQL Server
                                </small>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-dark btn-sm disabled">
                                    <i class="fab fa-github me-1"></i>Coming Soon
                                </a>
                                <a href="#" class="btn btn-primary btn-sm disabled">
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
            <h2 class="h1 mb-4">Ready to Build Your Next App?</h2>
            <p class="lead mb-4">Let's collaborate and bring your mobile or web application ideas to life with cutting-edge technology!</p>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="d-flex flex-wrap justify-content-center gap-3">
                        <a href="Contact.aspx" class="btn btn-light btn-lg btn-custom">
                            <i class="fas fa-paper-plane me-2"></i>Start a Project
                        </a>
                        <a href="About.aspx" class="btn btn-outline-light btn-lg btn-custom">
                            <i class="fas fa-user me-2"></i>Learn More About Me
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
            const statsCards = document.querySelectorAll('.stat-number[data-count]');
            
            const animateCounter = (element) => {
                const target = parseInt(element.getAttribute('data-count'));
                if (target > 0) {
                    const duration = 2000;
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
                        observer.unobserve(entry.target);
                    }
                });
            });
            
            statsCards.forEach(card => observer.observe(card));

            // Animate progress bars
            const progressBars = document.querySelectorAll('.progress-bar');
            progressBars.forEach(bar => {
                const width = bar.style.width;
                bar.style.width = '0%';
                setTimeout(() => {
                    bar.style.width = width;
                }, 500);
            });
        });
    </script>
</asp:Content>