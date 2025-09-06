<%@ Page Title="Skills & Technologies" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Skills.aspx.cs" Inherits="WebApplication1.Skills" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Explore Ariyan Aftab Spandan's technical skills and technologies in mobile and web development." />
    <meta name="keywords" content="skills, technologies, programming languages, frameworks, Ariyan Aftab Spandan" />
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Skills Hero Section with Same Design as Home -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center position-relative">
                <!-- Central Dividing Line -->
                <div class="hero-divider"></div>
                
                <!-- Left Side - Skills Information -->
                <div class="col-lg-6 hero-left">
                    <div class="hero-content fade-in">
                        <h1 class="hero-title">Skills & Technologies</h1>
                        <p class="hero-tagline">My Technical Expertise</p>
                        <div class="hero-description">
                            <p>I have extensive experience with a wide range of programming languages, frameworks, and development tools.</p>
                            <p>From mobile app development to machine learning, I continuously expand my skillset to deliver cutting-edge solutions.</p>
                        </div>
                        <div class="hero-buttons">
                            <a href="Projects.aspx" class="btn btn-hero btn-lg btn-custom me-3">
                                <i class="fas fa-folder-open me-2"></i>View Projects
                            </a>
                            <a href="Contact.aspx" class="btn btn-hero-outline btn-lg btn-custom">
                                <i class="fas fa-envelope me-2"></i>Hire Me
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Right Side - Skills Icon/Visual -->
                <div class="col-lg-6 hero-right text-center">
                    <div class="slide-up">
                        <div class="profile-container">
                            <div class="skills-visual-hero">
                                <div class="skills-icon-grid">
                                    <i class="fab fa-java skill-icon"></i>
                                    <i class="fab fa-js-square skill-icon"></i>
                                    <i class="fab fa-python skill-icon"></i>
                                    <i class="fab fa-react skill-icon"></i>
                                    <i class="fab fa-android skill-icon"></i>
                                    <i class="fab fa-apple skill-icon"></i>
                                    <i class="fas fa-brain skill-icon"></i>
                                    <i class="fab fa-microsoft skill-icon"></i>
                                    <i class="fas fa-database skill-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Programming Languages Section -->
    <section class="py-5 skills-section">
        <div class="container">
            <h2 class="section-title">Programming Languages</h2>
            <div class="row">
                <div class="col-lg-6 mb-4">
                    <div class="skills-container">
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-java me-2 text-danger"></i>Java
                                </span>
                                <span class="skill-percentage">95%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 95%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-js-square me-2 text-warning"></i>JavaScript
                                </span>
                                <span class="skill-percentage">90%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 90%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-python me-2 text-info"></i>Python
                                </span>
                                <span class="skill-percentage">85%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 85%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fas fa-code me-2 text-primary"></i>C#
                                </span>
                                <span class="skill-percentage">88%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 88%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6 mb-4">
                    <div class="skills-container">
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fas fa-code me-2 text-secondary"></i>C++
                                </span>
                                <span class="skill-percentage">80%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 80%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fas fa-code me-2 text-dark"></i>C
                                </span>
                                <span class="skill-percentage">75%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 75%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-php me-2 text-primary"></i>PHP
                                </span>
                                <span class="skill-percentage">70%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 70%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-swift me-2 text-warning"></i>Swift
                                </span>
                                <span class="skill-percentage">78%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 78%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Frameworks & Libraries Section -->
    <section class="py-5 services-section">
        <div class="container">
            <h2 class="section-title">Frameworks & Libraries</h2>
            <div class="row">
                <div class="col-lg-6 mb-4">
                    <div class="skills-container">
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-react me-2 text-info"></i>React Framework
                                </span>
                                <span class="skill-percentage">92%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 92%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-react me-2 text-info"></i>React Native
                                </span>
                                <span class="skill-percentage">88%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 88%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-microsoft me-2 text-primary"></i>ASP.NET
                                </span>
                                <span class="skill-percentage">85%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 85%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fas fa-mobile-alt me-2 text-primary"></i>Flutter
                                </span>
                                <span class="skill-percentage">82%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 82%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6 mb-4">
                    <div class="skills-container">
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-node-js me-2 text-success"></i>Node.js
                                </span>
                                <span class="skill-percentage">80%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 80%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-angular me-2 text-danger"></i>Angular
                                </span>
                                <span class="skill-percentage">75%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 75%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-laravel me-2 text-danger"></i>Laravel
                                </span>
                                <span class="skill-percentage">70%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 70%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-bootstrap me-2 text-primary"></i>Bootstrap
                                </span>
                                <span class="skill-percentage">95%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 95%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Development Tools & Technologies Section -->
    <section class="py-5 skills-section">
        <div class="container">
            <h2 class="section-title">Development Tools & Technologies</h2>
            <div class="row">
                <div class="col-lg-6 mb-4">
                    <div class="skills-container">
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fas fa-code me-2 text-primary"></i>Visual Studio
                                </span>
                                <span class="skill-percentage">95%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 95%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-android me-2 text-success"></i>Android Studio
                                </span>
                                <span class="skill-percentage">92%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 92%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fas fa-code me-2 text-warning"></i>IntelliJ IDEA
                                </span>
                                <span class="skill-percentage">88%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 88%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-linux me-2 text-dark"></i>Linux
                                </span>
                                <span class="skill-percentage">85%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 85%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6 mb-4">
                    <div class="skills-container">
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-git-alt me-2 text-danger"></i>Git & GitHub
                                </span>
                                <span class="skill-percentage">90%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 90%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fas fa-database me-2 text-info"></i>MySQL
                                </span>
                                <span class="skill-percentage">87%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 87%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fas fa-cloud me-2 text-primary"></i>Azure
                                </span>
                                <span class="skill-percentage">80%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 80%"></div>
                            </div>
                        </div>
                        
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-docker me-2 text-info"></i>Docker
                                </span>
                                <span class="skill-percentage">75%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 75%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Skill Categories Grid -->
    <section class="py-5 services-section">
        <div class="container">
            <h2 class="section-title">Skill Categories</h2>
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h5>Mobile Development</h5>
                        <p>Expert in Android, iOS, React Native, and Flutter development for cross-platform mobile applications.</p>
                        <ul class="text-start">
                            <li>Android Native (Java/Kotlin)</li>
                            <li>iOS Native (Swift)</li>
                            <li>React Native</li>
                            <li>Flutter</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-globe"></i>
                        </div>
                        <h5>Web Development</h5>
                        <p>Full-stack web development using modern frameworks and technologies for responsive applications.</p>
                        <ul class="text-start">
                            <li>ASP.NET Framework/Core</li>
                            <li>React.js</li>
                            <li>Node.js</li>
                            <li>PHP & Laravel</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-brain"></i>
                        </div>
                        <h5>Machine Learning</h5>
                        <p>Developing intelligent solutions using machine learning algorithms and data science techniques.</p>
                        <ul class="text-start">
                            <li>Python & TensorFlow</li>
                            <li>Scikit-learn</li>
                            <li>Data Analysis</li>
                            <li>Predictive Modeling</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-cloud"></i>
                        </div>
                        <h5>Cloud Technologies</h5>
                        <p>Experience with cloud platforms and services for scalable and reliable applications.</p>
                        <ul class="text-start">
                            <li>Microsoft Azure</li>
                            <li>AWS Services</li>
                            <li>Google Firebase</li>
                            <li>Docker & Containers</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-tools"></i>
                        </div>
                        <h5>Development Tools</h5>
                        <p>Proficient with industry-standard development tools and IDEs for efficient coding.</p>
                        <ul class="text-start">
                            <li>Visual Studio</li>
                            <li>Android Studio</li>
                            <li>IntelliJ IDEA</li>
                            <li>Git & Version Control</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <h5>System Administration</h5>
                        <p>Knowledge of system administration and deployment on various platforms.</p>
                        <ul class="text-start">
                            <li>Linux Administration</li>
                            <li>Windows Server</li>
                            <li>CI/CD Pipelines</li>
                            <li>Performance Optimization</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate skill bars when they come into view
            const skillBars = document.querySelectorAll('.skill-progress');
            
            const animateSkillBar = (bar) => {
                const width = bar.style.width;
                bar.style.width = '0%';
                setTimeout(() => {
                    bar.style.width = width;
                }, 100);
            };
            
            // Intersection Observer for skill bar animation
            const skillObserver = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        animateSkillBar(entry.target);
                        skillObserver.unobserve(entry.target);
                    }
                });
            });
            
            skillBars.forEach(bar => skillObserver.observe(bar));
        });
    </script>
</asp:Content>