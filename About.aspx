<%@ Page Title="About Me" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebApplication1.About" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Learn more about me, my background, experience, and goals as a software developer." />
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- About Hero Section -->
    <section class="py-5 bg-primary text-white">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-4 fw-bold mb-3">About Me</h1>
                    <p class="lead">Get to know the person behind the code</p>
                </div>
                <div class="col-lg-4 text-center">
                    <i class="fas fa-user-circle fa-5x"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- About Content Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="about-content">
                        <h2 class="h3 mb-4">My Story</h2>
                        <div class="about-description">
                            <asp:Literal ID="litAboutDescription" runat="server" />
                        </div>
                        
                        <h3 class="h4 mt-5 mb-3">What I Do</h3>
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <div class="service-item">
                                    <div class="d-flex align-items-center mb-3">
                                        <i class="fas fa-code text-primary fa-2x me-3"></i>
                                        <h4 class="h5 mb-0">Web Development</h4>
                                    </div>
                                    <p>Creating responsive and dynamic web applications using modern technologies and best practices.</p>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="service-item">
                                    <div class="d-flex align-items-center mb-3">
                                        <i class="fas fa-database text-primary fa-2x me-3"></i>
                                        <h4 class="h5 mb-0">Database Design</h4>
                                    </div>
                                    <p>Designing efficient database schemas and optimizing queries for better performance.</p>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="service-item">
                                    <div class="d-flex align-items-center mb-3">
                                        <i class="fas fa-mobile-alt text-primary fa-2x me-3"></i>
                                        <h4 class="h5 mb-0">Responsive Design</h4>
                                    </div>
                                    <p>Building applications that work seamlessly across all devices and screen sizes.</p>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="service-item">
                                    <div class="d-flex align-items-center mb-3">
                                        <i class="fas fa-cogs text-primary fa-2x me-3"></i>
                                        <h4 class="h5 mb-0">Problem Solving</h4>
                                    </div>
                                    <p>Analyzing complex problems and developing efficient, scalable solutions.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="about-sidebar">
                        <!-- Profile Card -->
                        <div class="card mb-4">
                            <div class="card-body text-center">
                                <asp:Image ID="imgProfileLarge" runat="server" CssClass="rounded-circle mb-3" 
                                          ImageUrl="~/Images/profile-placeholder.jpg" 
                                          Width="150" Height="150" AlternateText="Profile Photo" />
                                <h4><asp:Literal ID="litFullName" runat="server" /></h4>
                                <p class="text-muted"><asp:Literal ID="litTagline" runat="server" /></p>
                                
                                <!-- Contact Info -->
                                <div class="contact-info mt-4">
                                    <div class="d-flex align-items-center mb-2" runat="server" id="divEmail" visible="false">
                                        <i class="fas fa-envelope text-primary me-2"></i>
                                        <asp:Literal ID="litEmail" runat="server" />
                                    </div>
                                    <div class="d-flex align-items-center mb-2" runat="server" id="divPhone" visible="false">
                                        <i class="fas fa-phone text-primary me-2"></i>
                                        <asp:Literal ID="litPhone" runat="server" />
                                    </div>
                                    <div class="d-flex align-items-center mb-2" runat="server" id="divAddress" visible="false">
                                        <i class="fas fa-map-marker-alt text-primary me-2"></i>
                                        <asp:Literal ID="litAddress" runat="server" />
                                    </div>
                                </div>
                                
                                <!-- Social Links -->
                                <div class="social-links mt-4">
                                    <asp:HyperLink ID="lnkLinkedIn" runat="server" CssClass="btn btn-outline-primary btn-sm me-2" 
                                                  Visible="false" Target="_blank">
                                        <i class="fab fa-linkedin"></i>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkGitHub" runat="server" CssClass="btn btn-outline-dark btn-sm me-2" 
                                                  Visible="false" Target="_blank">
                                        <i class="fab fa-github"></i>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkTwitter" runat="server" CssClass="btn btn-outline-info btn-sm me-2" 
                                                  Visible="false" Target="_blank">
                                        <i class="fab fa-twitter"></i>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkFacebook" runat="server" CssClass="btn btn-outline-primary btn-sm" 
                                                  Visible="false" Target="_blank">
                                        <i class="fab fa-facebook"></i>
                                    </asp:HyperLink>
                                </div>
                                
                                <!-- Download Resume -->
                                <div class="mt-4">
                                    <asp:HyperLink ID="lnkResume" runat="server" CssClass="btn btn-primary btn-custom w-100" 
                                                  Visible="false" Target="_blank">
                                        <i class="fas fa-download me-2"></i>Download Resume
                                    </asp:HyperLink>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Quick Stats -->
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Quick Stats</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Projects:</span>
                                    <strong><asp:Literal ID="litProjectsCount" runat="server" /></strong>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Skills:</span>
                                    <strong><asp:Literal ID="litSkillsCount" runat="server" /></strong>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Achievements:</span>
                                    <strong><asp:Literal ID="litAchievementsCount" runat="server" /></strong>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span>Certificates:</span>
                                    <strong><asp:Literal ID="litCertificatesCount" runat="server" /></strong>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Skills Overview Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <h2 class="section-title">Skills Overview</h2>
            <div class="row">
                <div class="col-lg-6">
                    <h4 class="mb-3">Technical Skills</h4>
                    <asp:Repeater ID="rptTechnicalSkills" runat="server">
                        <ItemTemplate>
                            <div class="skill-item mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <span class="fw-medium">
                                        <i class="<%# Eval("IconClass") %> me-2"></i>
                                        <%# Eval("SkillName") %>
                                    </span>
                                    <span class="text-muted"><%# Eval("ProficiencyLevel") %>%</span>
                                </div>
                                <div class="progress" style="height: 6px;">
                                    <div class="progress-bar bg-primary" role="progressbar" 
                                         style="width: <%# Eval("ProficiencyLevel") %>%"
                                         aria-valuenow="<%# Eval("ProficiencyLevel") %>" 
                                         aria-valuemin="0" aria-valuemax="100">
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="col-lg-6">
                    <h4 class="mb-3">Soft Skills</h4>
                    <asp:Repeater ID="rptSoftSkills" runat="server">
                        <ItemTemplate>
                            <div class="skill-item mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <span class="fw-medium">
                                        <i class="<%# Eval("IconClass") %> me-2"></i>
                                        <%# Eval("SkillName") %>
                                    </span>
                                    <span class="text-muted"><%# Eval("ProficiencyLevel") %>%</span>
                                </div>
                                <div class="progress" style="height: 6px;">
                                    <div class="progress-bar bg-success" role="progressbar" 
                                         style="width: <%# Eval("ProficiencyLevel") %>%"
                                         aria-valuenow="<%# Eval("ProficiencyLevel") %>" 
                                         aria-valuemin="0" aria-valuemax="100">
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div class="text-center mt-4">
                <a href="Skills.aspx" class="btn btn-primary btn-custom">
                    <i class="fas fa-eye me-2"></i>View All Skills
                </a>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="py-5 bg-primary text-white">
        <div class="container text-center">
            <h2 class="h1 mb-3">Ready to Start a Project?</h2>
            <p class="lead mb-4">Let's discuss how we can work together to bring your ideas to life.</p>
            <a href="Contact.aspx" class="btn btn-light btn-lg btn-custom">
                <i class="fas fa-paper-plane me-2"></i>Get In Touch
            </a>
        </div>
    </section>
</asp:Content>