<%@ Page Title="About Me" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebApplication1.About" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Learn more about Ariyan Aftab Spandan - App Developer specializing in mobile and web applications." />
    <meta name="keywords" content="about, app developer, mobile developer, web developer, Ariyan Aftab Spandan" />
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- About Hero Section with Same Design as Home -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center position-relative">
                <!-- Central Dividing Line -->
                <div class="hero-divider"></div>
                
                <!-- Left Side - About Information -->
                <div class="col-lg-6 hero-left">
                    <div class="hero-content fade-in">
                        <h1 class="hero-title">
                            <asp:Literal ID="litFullName" runat="server" Text="About Me" />
                        </h1>
                        <p class="hero-tagline">
                            <asp:Literal ID="litTagline" runat="server" Text="App & Web Developer | ML Enthusiast" />
                        </p>
                        <div class="hero-description">
                            <asp:Literal ID="litAboutDescription" runat="server" Text="I am a passionate app developer specializing in creating innovative mobile and web applications. With expertise in modern development frameworks and a keen eye for user experience, I transform ideas into powerful, user-friendly applications that make a difference." />
                        </div>
                        
                        <!-- Contact Info -->
                        <div class="contact-info-cards mt-4">
                            <div class="row">
                                <div class="col-md-6 mb-3" runat="server" id="divEmail" visible="false">
                                    <div class="info-card-hero">
                                        <i class="fas fa-envelope"></i>
                                        <div>
                                            <h6>Email</h6>
                                            <asp:Literal ID="litEmail" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3" runat="server" id="divPhone" visible="false">
                                    <div class="info-card-hero">
                                        <i class="fas fa-phone"></i>
                                        <div>
                                            <h6>Phone</h6>
                                            <asp:Literal ID="litPhone" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="hero-buttons">
                            <a href="Contact.aspx" class="btn btn-hero btn-lg btn-custom me-3">
                                <i class="fas fa-paper-plane me-2"></i>Get In Touch
                            </a>
                            <a href="Projects.aspx" class="btn btn-hero-outline btn-lg btn-custom">
                                <i class="fas fa-folder-open me-2"></i>View Projects
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Right Side - About Profile Photo -->
                <div class="col-lg-6 hero-right text-center">
                    <div class="slide-up">
                        <div class="profile-container">
                            <asp:Image ID="imgProfileLarge" runat="server" CssClass="profile-img-hero img-fluid" 
                                      ImageUrl="~/Images/profile/about.jpg" AlternateText="Ariyan Aftab Spandan" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="py-5 stats-section">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="5">
                            <asp:Literal ID="litProjectsCount" runat="server" Text="8" />
                        </h3>
                        <p class="stat-label">Apps Developed</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="12">
                            <asp:Literal ID="litSkillsCount" runat="server" Text="15" />
                        </h3>
                        <p class="stat-label">Technologies</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="3">
                            <asp:Literal ID="litAchievementsCount" runat="server" Text="5" />
                        </h3>
                        <p class="stat-label">Achievements</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="7">
                            <asp:Literal ID="litCertificatesCount" runat="server" Text="12" />
                        </h3>
                        <p class="stat-label">Certifications</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Skills Section -->
    <section class="py-5 skills-section">
        <div class="container">
            <h2 class="section-title">My Skills</h2>
            <div class="row">
                <div class="col-lg-6 mb-4">
                    <h4 class="skills-category-title">
                        <i class="fas fa-code me-2"></i>Technical Skills
                    </h4>
                    <div class="skills-container">
                        <!-- Sample Technical Skills -->
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fab fa-android me-2"></i>Android Development
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
                                    <i class="fab fa-apple me-2"></i>iOS Development
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
                                    <i class="fab fa-react me-2"></i>React Native
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
                                    <i class="fab fa-microsoft me-2"></i>ASP.NET
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
                                    <i class="fas fa-brain me-2"></i>Machine Learning
                                </span>
                                <span class="skill-percentage">70%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 70%"></div>
                            </div>
                        </div>
                        
                        <!-- Dynamic Technical Skills will be loaded here -->
                        <asp:Repeater ID="rptTechnicalSkills" runat="server">
                            <ItemTemplate>
                                <div class="skill-item">
                                    <div class="skill-header">
                                        <span class="skill-name">
                                            <i class="<%# Eval("IconClass") %> me-2"></i><%# Eval("SkillName") %>
                                        </span>
                                        <span class="skill-percentage"><%# Eval("ProficiencyLevel") %>%</span>
                                    </div>
                                    <div class="skill-bar">
                                        <div class="skill-progress" style="width: <%# Eval("ProficiencyLevel") %>%"></div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                
                <div class="col-lg-6 mb-4">
                    <h4 class="skills-category-title">
                        <i class="fas fa-user-cog me-2"></i>Soft Skills
                    </h4>
                    <div class="skills-container">
                        <!-- Sample Soft Skills -->
                        <div class="skill-item">
                            <div class="skill-header">
                                <span class="skill-name">
                                    <i class="fas fa-lightbulb me-2"></i>Problem Solving
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
                                    <i class="fas fa-users me-2"></i>Team Collaboration
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
                                    <i class="fas fa-comments me-2"></i>Communication
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
                                    <i class="fas fa-clock me-2"></i>Time Management
                                </span>
                                <span class="skill-percentage">88%</span>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: 88%"></div>
                            </div>
                        </div>
                        
                        <!-- Dynamic Soft Skills will be loaded here -->
                        <asp:Repeater ID="rptSoftSkills" runat="server">
                            <ItemTemplate>
                                <div class="skill-item">
                                    <div class="skill-header">
                                        <span class="skill-name">
                                            <i class="<%# Eval("IconClass") %> me-2"></i><%# Eval("SkillName") %>
                                        </span>
                                        <span class="skill-percentage"><%# Eval("ProficiencyLevel") %>%</span>
                                    </div>
                                    <div class="skill-bar">
                                        <div class="skill-progress" style="width: <%# Eval("ProficiencyLevel") %>%"></div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- What I Do Section -->
    <section class="py-5 services-section">
        <div class="container">
            <h2 class="section-title">What I Do</h2>
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h5>Mobile App Development</h5>
                        <p>Creating native and cross-platform mobile applications for Android and iOS with focus on performance and user experience.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-globe"></i>
                        </div>
                        <h5>Web Application Development</h5>
                        <p>Building responsive web applications using modern frameworks and technologies with scalable architecture.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-brain"></i>
                        </div>
                        <h5>Machine Learning Solutions</h5>
                        <p>Developing intelligent applications using machine learning algorithms to solve complex real-world problems.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-cloud"></i>
                        </div>
                        <h5>Cloud Integration</h5>
                        <p>Implementing cloud-based solutions and APIs to enhance application functionality and scalability.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <h5>App Optimization</h5>
                        <p>Performance optimization and debugging to ensure applications run smoothly and efficiently.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-handshake"></i>
                        </div>
                        <h5>Consultation</h5>
                        <p>Providing technical consultation and guidance for app development projects and technology decisions.</p>
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
            
            // Animate stat numbers
            const statNumbers = document.querySelectorAll('.stat-number[data-count]');
            
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
            
            // Intersection Observer for stat counter animation
            const statObserver = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        animateCounter(entry.target);
                        statObserver.unobserve(entry.target);
                    }
                });
            });
            
            statNumbers.forEach(stat => statObserver.observe(stat));
        });
    </script>
</asp:Content>