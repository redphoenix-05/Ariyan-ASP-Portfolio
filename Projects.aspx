<%@ Page Title="Projects" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="WebApplication1.Projects" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Explore Ariyan Aftab Spandan's portfolio of mobile and web application projects." />
    <meta name="keywords" content="projects, portfolio, mobile apps, web applications, Ariyan Aftab Spandan" />
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Projects Hero Section -->
    <section class="about-hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-12 text-center">
                    <div class="about-content">
                        <h1 class="about-title">My Projects</h1>
                        <p class="about-tagline">Portfolio of Mobile & Web Applications</p>
                        <div class="about-description">
                            <p>Here's a showcase of my recent projects, demonstrating my skills in mobile and web development across various technologies and platforms.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Projects Section -->
    <section class="py-5 skills-section">
        <div class="container">
            <h2 class="section-title">Featured Projects</h2>
            <div class="row">
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100 project-card">
                        <img src="~/Images/projects/project1.jpg" class="card-img-top" alt="Portfolio Mobile App" 
                             onerror="this.src='https://via.placeholder.com/500x300/007bff/ffffff?text=Portfolio+Mobile+App'">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">Portfolio Mobile App</h5>
                                <span class="badge bg-primary">React Native</span>
                            </div>
                            <p class="card-text">A cross-platform mobile application showcasing my portfolio with interactive features, smooth animations, and real-time data synchronization.</p>
                            
                            <div class="tech-stack mb-3">
                                <h6 class="mb-2">Tech Stack:</h6>
                                <div class="d-flex flex-wrap gap-1">
                                    <span class="badge bg-info">React Native</span>
                                    <span class="badge bg-warning">Firebase</span>
                                    <span class="badge bg-success">Redux</span>
                                    <span class="badge bg-secondary">TypeScript</span>
                                </div>
                            </div>
                            
                            <div class="features mb-3">
                                <h6 class="mb-2">Key Features:</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success me-2"></i>Cross-platform compatibility</li>
                                    <li><i class="fas fa-check text-success me-2"></i>Real-time data sync</li>
                                    <li><i class="fas fa-check text-success me-2"></i>Offline functionality</li>
                                    <li><i class="fas fa-check text-success me-2"></i>Push notifications</li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="https://github.com/redphoenix-05/Ariyan-ASP-Portfolio" class="btn btn-outline-primary btn-sm" target="_blank">
                                    <i class="fab fa-github me-1"></i>Source Code
                                </a>
                                <a href="#" class="btn btn-primary btn-sm">
                                    <i class="fas fa-external-link-alt me-1"></i>Live Demo
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100 project-card">
                        <img src="~/Images/projects/project2.jpg" class="card-img-top" alt="E-Commerce Mobile App" 
                             onerror="this.src='https://via.placeholder.com/500x300/28a745/ffffff?text=E-Commerce+Mobile+App'">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">E-Commerce Mobile App</h5>
                                <span class="badge bg-success">Flutter</span>
                            </div>
                            <p class="card-text">Full-featured shopping application with payment integration, user authentication, order tracking, and comprehensive admin panel.</p>
                            
                            <div class="tech-stack mb-3">
                                <h6 class="mb-2">Tech Stack:</h6>
                                <div class="d-flex flex-wrap gap-1">
                                    <span class="badge bg-primary">Flutter</span>
                                    <span class="badge bg-success">Node.js</span>
                                    <span class="badge bg-info">MongoDB</span>
                                    <span class="badge bg-warning">Stripe API</span>
                                </div>
                            </div>
                            
                            <div class="features mb-3">
                                <h6 class="mb-2">Key Features:</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success me-2"></i>Secure payment processing</li>
                                    <li><i class="fas fa-check text-success me-2"></i>Real-time order tracking</li>
                                    <li><i class="fas fa-check text-success me-2"></i>User authentication</li>
                                    <li><i class="fas fa-check text-success me-2"></i>Admin dashboard</li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-secondary btn-sm disabled">
                                    <i class="fab fa-github me-1"></i>Private Repo
                                </a>
                                <a href="#" class="btn btn-secondary btn-sm disabled">
                                    <i class="fas fa-external-link-alt me-1"></i>Coming Soon
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- More Projects Section -->
    <section class="py-5 services-section">
        <div class="container">
            <h2 class="section-title">More Projects</h2>
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100 project-card">
                        <img src="~/Images/projects/project3.jpg" class="card-img-top" alt="Task Manager Web App" 
                             onerror="this.src='https://via.placeholder.com/400x250/dc3545/ffffff?text=Task+Manager+Web+App'">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">Task Manager Web App</h5>
                                <span class="badge bg-danger">ASP.NET</span>
                            </div>
                            <p class="card-text">Productivity application with team collaboration features, real-time updates, and comprehensive project management tools.</p>
                            
                            <div class="tech-stack mb-3">
                                <small class="text-muted">
                                    <strong>Tech:</strong> ASP.NET Core, SignalR, SQL Server, Bootstrap
                                </small>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-secondary btn-sm disabled">
                                    <i class="fab fa-github me-1"></i>Coming Soon
                                </a>
                                <a href="#" class="btn btn-secondary btn-sm disabled">
                                    <i class="fas fa-external-link-alt me-1"></i>In Development
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100 project-card">
                        <img src="https://via.placeholder.com/400x250/6f42c1/ffffff?text=Weather+App" class="card-img-top" alt="Weather App">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">Weather Forecast App</h5>
                                <span class="badge bg-info">Android</span>
                            </div>
                            <p class="card-text">Native Android application providing detailed weather forecasts with beautiful UI and location-based services.</p>
                            
                            <div class="tech-stack mb-3">
                                <small class="text-muted">
                                    <strong>Tech:</strong> Java, Android SDK, Weather API, Material Design
                                </small>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-primary btn-sm">
                                    <i class="fab fa-github me-1"></i>Source Code
                                </a>
                                <a href="#" class="btn btn-primary btn-sm">
                                    <i class="fas fa-download me-1"></i>Download APK
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100 project-card">
                        <img src="https://via.placeholder.com/400x250/fd7e14/ffffff?text=Chat+Application" class="card-img-top" alt="Chat Application">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">Real-time Chat App</h5>
                                <span class="badge bg-warning">React</span>
                            </div>
                            <p class="card-text">Real-time messaging application with group chats, file sharing, and user presence indicators.</p>
                            
                            <div class="tech-stack mb-3">
                                <small class="text-muted">
                                    <strong>Tech:</strong> React.js, Socket.io, Node.js, MongoDB
                                </small>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-primary btn-sm">
                                    <i class="fab fa-github me-1"></i>Source Code
                                </a>
                                <a href="#" class="btn btn-primary btn-sm">
                                    <i class="fas fa-external-link-alt me-1"></i>Live Demo
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100 project-card">
                        <img src="https://via.placeholder.com/400x250/20c997/ffffff?text=Finance+Tracker" class="card-img-top" alt="Finance Tracker">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">Personal Finance Tracker</h5>
                                <span class="badge bg-success">Flutter</span>
                            </div>
                            <p class="card-text">Mobile app for tracking personal expenses and income with detailed analytics and budget planning features.</p>
                            
                            <div class="tech-stack mb-3">
                                <small class="text-muted">
                                    <strong>Tech:</strong> Flutter, SQLite, Charts Library, Provider
                                </small>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-primary btn-sm">
                                    <i class="fab fa-github me-1"></i>Source Code
                                </a>
                                <a href="#" class="btn btn-primary btn-sm">
                                    <i class="fas fa-download me-1"></i>Download APK
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100 project-card">
                        <img src="https://via.placeholder.com/400x250/e83e8c/ffffff?text=Recipe+App" class="card-img-top" alt="Recipe App">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">Recipe Sharing App</h5>
                                <span class="badge bg-danger">React Native</span>
                            </div>
                            <p class="card-text">Social platform for sharing and discovering recipes with photo upload, rating system, and meal planning features.</p>
                            
                            <div class="tech-stack mb-3">
                                <small class="text-muted">
                                    <strong>Tech:</strong> React Native, Firebase, Redux, Image Picker
                                </small>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-secondary btn-sm disabled">
                                    <i class="fab fa-github me-1"></i>In Development
                                </a>
                                <a href="#" class="btn btn-secondary btn-sm disabled">
                                    <i class="fas fa-external-link-alt me-1"></i>Coming Soon
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100 project-card">
                        <img src="https://via.placeholder.com/400x250/6610f2/ffffff?text=Learning+Management" class="card-img-top" alt="Learning Management System">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">Learning Management System</h5>
                                <span class="badge bg-primary">ASP.NET</span>
                            </div>
                            <p class="card-text">Web-based LMS with course management, student enrollment, quiz system, and progress tracking capabilities.</p>
                            
                            <div class="tech-stack mb-3">
                                <small class="text-muted">
                                    <strong>Tech:</strong> ASP.NET MVC, Entity Framework, SQL Server, jQuery
                                </small>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-primary btn-sm">
                                    <i class="fab fa-github me-1"></i>Source Code
                                </a>
                                <a href="#" class="btn btn-primary btn-sm">
                                    <i class="fas fa-external-link-alt me-1"></i>Live Demo
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Project Statistics -->
    <section class="py-5 skills-section">
        <div class="container">
            <h2 class="section-title">Project Statistics</h2>
            <div class="row text-center">
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="12">0</h3>
                        <p class="stat-label">Total Projects</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="8">0</h3>
                        <p class="stat-label">Mobile Apps</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="4">0</h3>
                        <p class="stat-label">Web Applications</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="6">0</h3>
                        <p class="stat-label">Open Source</p>
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
        });
    </script>
</asp:Content>