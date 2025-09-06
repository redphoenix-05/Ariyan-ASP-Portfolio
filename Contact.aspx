<%@ Page Title="Contact Me" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="WebApplication1.Contact" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Get in touch with Ariyan Aftab Spandan - App Developer. Contact for mobile and web development projects." />
    <meta name="keywords" content="contact, app developer, mobile developer, web developer, hire, Ariyan Aftab Spandan" />
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Contact Hero Section with Same Design as Home -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center position-relative">
                <!-- Central Dividing Line -->
                <div class="hero-divider"></div>
                
                <!-- Left Side - Contact Information and Social Links -->
                <div class="col-lg-6 hero-left">
                    <div class="hero-content fade-in">
                        <h1 class="hero-title">Get In Touch</h1>
                        <p class="hero-tagline">Let's Create Something Amazing Together</p>
                        <div class="hero-description">
                            <p>Ready to bring your app idea to life? Whether you need a mobile application, web solution, or machine learning integration, I'm here to help.</p>
                            <p>Let's discuss your project and explore how we can create innovative solutions that make a difference.</p>
                        </div>
                        
                        <!-- Social Media Links -->
                        <div class="social-links-hero mt-4 mb-4">
                            <h5 class="mb-3" style="color: var(--hero-text);">Connect With Me</h5>
                            <div class="social-buttons">
                                <a href="https://www.linkedin.com/in/ariyan-aftab-spandan" class="social-btn linkedin" target="_blank">
                                    <i class="fab fa-linkedin-in"></i>
                                    <span>LinkedIn</span>
                                </a>
                                <a href="https://github.com/redphoenix-05" class="social-btn github" target="_blank">
                                    <i class="fab fa-github"></i>
                                    <span>GitHub</span>
                                </a>
                                <a href="https://www.instagram.com/ariyan_aftab_spandan" class="social-btn instagram" target="_blank">
                                    <i class="fab fa-instagram"></i>
                                    <span>Instagram</span>
                                </a>
                                <a href="https://www.facebook.com/ariyan.aftab.spandan" class="social-btn facebook" target="_blank">
                                    <i class="fab fa-facebook-f"></i>
                                    <span>Facebook</span>
                                </a>
                            </div>
                        </div>
                        
                        <!-- Quick Contact Info -->
                        <div class="contact-info-quick">
                            <div class="info-item-hero">
                                <i class="fas fa-envelope"></i>
                                <div>
                                    <h6>Email</h6>
                                    <span>ariyan.aftab@example.com</span>
                                </div>
                            </div>
                            <div class="info-item-hero">
                                <i class="fas fa-map-marker-alt"></i>
                                <div>
                                    <h6>Location</h6>
                                    <span>Available for Remote & Local Projects</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Right Side - Contact Form -->
                <div class="col-lg-6 hero-right">
                    <div class="slide-up">
                        <div class="contact-form-container">
                            <div class="contact-form-hero">
                                <h4 class="form-title mb-4">Send Me a Message</h4>
                                
                                <!-- Success/Error Messages -->
                                <asp:Panel ID="pnlSuccess" runat="server" CssClass="alert alert-success" Visible="false">
                                    <i class="fas fa-check-circle me-2"></i>
                                    <asp:Literal ID="litSuccessMessage" runat="server" />
                                </asp:Panel>
                                
                                <asp:Panel ID="pnlError" runat="server" CssClass="alert alert-danger" Visible="false">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    <asp:Literal ID="litErrorMessage" runat="server" />
                                </asp:Panel>
                                
                                <!-- Contact Form -->
                                <div class="form-group mb-3">
                                    <label for="txtName" class="form-label">
                                        <i class="fas fa-user me-2"></i>Full Name
                                    </label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control form-control-hero" 
                                                placeholder="Enter your full name" MaxLength="100" />
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                                                               ErrorMessage="Name is required" CssClass="text-danger small" 
                                                               ValidationGroup="ContactForm" Display="Dynamic" />
                                </div>
                                
                                <div class="form-group mb-3">
                                    <label for="txtEmail" class="form-label">
                                        <i class="fas fa-envelope me-2"></i>Email Address
                                    </label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control form-control-hero" 
                                                TextMode="Email" placeholder="Enter your email address" MaxLength="100" />
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                                                               ErrorMessage="Email is required" CssClass="text-danger small" 
                                                               ValidationGroup="ContactForm" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" 
                                                                   ErrorMessage="Please enter a valid email address" 
                                                                   ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" 
                                                                   CssClass="text-danger small" ValidationGroup="ContactForm" Display="Dynamic" />
                                </div>
                                
                                <div class="form-group mb-3">
                                    <label for="txtPhone" class="form-label">
                                        <i class="fas fa-phone me-2"></i>Phone Number
                                    </label>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control form-control-hero" 
                                                placeholder="Enter your phone number (optional)" MaxLength="20" />
                                    <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" 
                                                                   ErrorMessage="Please enter a valid phone number" 
                                                                   ValidationExpression="^[\+]?[0-9\s\-\(\)]{10,20}$" 
                                                                   CssClass="text-danger small" ValidationGroup="ContactForm" Display="Dynamic" />
                                </div>
                                
                                <div class="form-group mb-4">
                                    <label for="txtMessage" class="form-label">
                                        <i class="fas fa-comment me-2"></i>Message
                                    </label>
                                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control form-control-hero" 
                                                TextMode="MultiLine" Rows="5" 
                                                placeholder="Tell me about your project or inquiry..." MaxLength="1000" />
                                    <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" 
                                                               ErrorMessage="Message is required" CssClass="text-danger small" 
                                                               ValidationGroup="ContactForm" Display="Dynamic" />
                                </div>
                                
                                <div class="form-group text-center">
                                    <asp:Button ID="btnSendMessage" runat="server" CssClass="btn btn-hero btn-lg w-100" 
                                               Text="Send Message" OnClick="btnSendMessage_Click" 
                                               ValidationGroup="ContactForm" />
                                    <div class="mt-3">
                                        <small class="text-muted">
                                            <i class="fas fa-shield-alt me-1"></i>
                                            Your information is secure and will not be shared with third parties.
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Additional Contact Options -->
    <section class="py-5 stats-section">
        <div class="container">
            <h2 class="section-title">Other Ways to Reach Me</h2>
            <div class="row text-center">
                <div class="col-md-3 mb-4">
                    <div class="stat-card contact-option-card">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h5>Email</h5>
                        <p>ariyan.aftab@example.com</p>
                        <a href="mailto:ariyan.aftab@example.com" class="btn btn-outline-primary btn-sm">
                            <i class="fas fa-paper-plane me-1"></i>Send Email
                        </a>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card contact-option-card">
                        <div class="contact-icon">
                            <i class="fab fa-whatsapp"></i>
                        </div>
                        <h5>WhatsApp</h5>
                        <p>Quick messaging for urgent queries</p>
                        <a href="https://wa.me/1234567890" class="btn btn-outline-success btn-sm" target="_blank">
                            <i class="fab fa-whatsapp me-1"></i>Message
                        </a>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card contact-option-card">
                        <div class="contact-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <h5>Schedule Call</h5>
                        <p>Book a consultation meeting</p>
                        <a href="#" class="btn btn-outline-info btn-sm">
                            <i class="fas fa-calendar-plus me-1"></i>Book Now
                        </a>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card contact-option-card">
                        <div class="contact-icon">
                            <i class="fas fa-download"></i>
                        </div>
                        <h5>Resume</h5>
                        <p>Download my latest resume</p>
                        <a href="~/Documents/Ariyan_Resume.pdf" class="btn btn-outline-secondary btn-sm" target="_blank">
                            <i class="fas fa-file-pdf me-1"></i>Download
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQ Section -->
    <section class="py-5 skills-section">
        <div class="container">
            <h2 class="section-title">Frequently Asked Questions</h2>
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="accordion" id="faqAccordion">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="faq1">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1">
                                    <i class="fas fa-question-circle me-2"></i>
                                    What types of projects do you work on?
                                </button>
                            </h2>
                            <div id="collapse1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    I specialize in mobile app development (Android & iOS), web applications, and machine learning solutions. 
                                    I work on both native and cross-platform applications using technologies like React Native, Flutter, ASP.NET, and Python.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="faq2">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2">
                                    <i class="fas fa-clock me-2"></i>
                                    What is your typical project timeline?
                                </button>
                            </h2>
                            <div id="collapse2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    Project timelines vary based on complexity. A simple mobile app typically takes 4-8 weeks, 
                                    while complex applications with ML integration may take 3-6 months. I provide detailed timelines during consultation.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="faq3">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3">
                                    <i class="fas fa-dollar-sign me-2"></i>
                                    How do you structure your pricing?
                                </button>
                            </h2>
                            <div id="collapse3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    I offer flexible pricing models including fixed-price projects, hourly rates, and retainer agreements. 
                                    Pricing depends on project scope, timeline, and complexity. Contact me for a detailed quote.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="faq4">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse4">
                                    <i class="fas fa-headset me-2"></i>
                                    Do you provide ongoing support?
                                </button>
                            </h2>
                            <div id="collapse4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    Yes! I provide post-launch support including bug fixes, updates, and feature enhancements. 
                                    I also offer maintenance packages to keep your application running smoothly and up-to-date.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add smooth focus effects to form inputs
            const formInputs = document.querySelectorAll('.form-control-hero');
            
            formInputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('focused');
                });
                
                input.addEventListener('blur', function() {
                    if (this.value === '') {
                        this.parentElement.classList.remove('focused');
                    }
                });
            });
            
            // Add loading state to submit button
            const submitBtn = document.getElementById('<%= btnSendMessage.ClientID %>');
            if (submitBtn) {
                submitBtn.addEventListener('click', function() {
                    if (Page_ClientValidate('ContactForm')) {
                        this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Sending...';
                        this.disabled = true;
                    }
                });
            }
        });
    </script>
</asp:Content>