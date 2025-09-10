<%@ Page Title="Contact Me" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="WebApplication1.Contact" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Get in touch with Ariyan Aftab Spandan - App Developer. Contact for mobile and web development projects." />
    <meta name="keywords" content="contact, app developer, mobile developer, web developer, hire, Ariyan Aftab Spandan" />
    
    <!-- Enhanced Social Media Button Styles -->
    <style>
        .social-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            justify-content: flex-start;
            align-items: center;
        }

        .social-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            color: white;
            border: 2px solid transparent;
            min-width: 120px;
            justify-content: center;
        }

        .social-btn i {
            font-size: 1.2rem;
            min-width: 20px;
            text-align: center;
        }

        .social-btn.linkedin {
            background: linear-gradient(135deg, #0077b5, #005885);
            box-shadow: 0 4px 15px rgba(0, 119, 181, 0.3);
        }

        .social-btn.linkedin:hover {
            background: linear-gradient(135deg, #005885, #004066);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 119, 181, 0.4);
            color: white;
        }

        .social-btn.github {
            background: linear-gradient(135deg, #333, #24292e);
            box-shadow: 0 4px 15px rgba(51, 51, 51, 0.3);
        }

        .social-btn.github:hover {
            background: linear-gradient(135deg, #24292e, #1a1e22);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(51, 51, 51, 0.4);
            color: white;
        }

        .social-btn.instagram {
            background: linear-gradient(135deg, #e4405f, #833ab4, #fd1d1d, #fcb045);
            box-shadow: 0 4px 15px rgba(228, 64, 95, 0.3);
        }

        .social-btn.instagram:hover {
            background: linear-gradient(135deg, #d31345, #7209b7, #fd1d1d, #fcb045);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(228, 64, 95, 0.4);
            color: white;
        }

        .social-btn.facebook {
            background: linear-gradient(135deg, #1877f2, #0d5cb6);
            box-shadow: 0 4px 15px rgba(24, 119, 242, 0.3);
        }

        .social-btn.facebook:hover {
            background: linear-gradient(135deg, #0d5cb6, #0a4a8a);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(24, 119, 242, 0.4);
            color: white;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .social-buttons {
                justify-content: center;
                gap: 0.75rem;
            }
            
            .social-btn {
                min-width: 110px;
                padding: 0.6rem 1rem;
                font-size: 0.85rem;
            }
            
            .social-btn i {
                font-size: 1.1rem;
            }
        }

        @media (max-width: 480px) {
            .social-buttons {
                flex-direction: column;
                gap: 0.5rem;
                width: 100%;
            }
            
            .social-btn {
                width: 100%;
                max-width: 200px;
            }
        }

        /* Ensure icons are loaded properly */
        .social-btn i::before {
            font-family: "Font Awesome 6 Brands" !important;
            font-weight: 400 !important;
        }

        /* Loading state for social buttons */
        .social-btn:active {
            transform: translateY(0);
            transition: transform 0.1s ease;
        }

        /* Accessibility improvements */
        .social-btn:focus {
            outline: 2px solid rgba(255, 255, 255, 0.5);
            outline-offset: 2px;
        }

        /* Additional contact info styling */
        .contact-info-quick .info-item-hero {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            backdrop-filter: blur(10px);
        }

        .contact-info-quick .info-item-hero i {
            font-size: 1.5rem;
            color: var(--hero-accent, #fff);
            min-width: 30px;
            text-align: center;
        }

        .contact-info-quick .info-item-hero h6 {
            margin: 0;
            font-weight: 600;
            color: var(--hero-text, #fff);
        }

        .contact-info-quick .info-item-hero span {
            color: var(--hero-text-secondary, rgba(255, 255, 255, 0.8));
            font-size: 0.9rem;
        }

        /* Contact Option Cards Styling */
        .contact-option-card {
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .contact-option-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border-color: #007bff;
        }

        .contact-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #007bff;
            transition: all 0.3s ease;
        }

        .contact-option-card:hover .contact-icon {
            transform: scale(1.1);
            color: #0056b3;
        }

        .contact-option-card h5 {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.75rem;
        }

        .contact-option-card p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            flex-grow: 1;
        }

        /* Specific icon colors for different platforms */
        .contact-option-card .fa-whatsapp {
            color: #25d366;
        }

        .contact-option-card .fa-linkedin-in {
            color: #0077b5;
        }

        .contact-option-card .fa-github {
            color: #333;
        }

        .contact-option-card .fa-instagram {
            background: linear-gradient(45deg, #f09433 0%,#e6683c 25%,#dc2743 50%,#cc2366 75%,#bc1888 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .contact-option-card .fa-facebook-f {
            color: #1877f2;
        }

        .contact-option-card .fa-envelope {
            color: #dc3545;
        }

        /* Button hover effects for contact cards */
        .contact-option-card .btn-outline-success:hover {
            background-color: #25d366;
            border-color: #25d366;
        }

        .contact-option-card .btn-outline-primary:hover {
            background-color: #0077b5;
            border-color: #0077b5;
        }

        .contact-option-card .btn-outline-dark:hover {
            background-color: #333;
            border-color: #333;
        }

        .contact-option-card .btn-outline-danger:hover {
            background: linear-gradient(45deg, #f09433 0%,#e6683c 25%,#dc2743 50%,#cc2366 75%,#bc1888 100%);
            border-color: #dc2743;
        }

        /* Ensure Font Awesome icons load properly */
        .fab, .fas {
            font-family: "Font Awesome 6 Free", "Font Awesome 6 Brands" !important;
        }

        .fab::before {
            font-family: "Font Awesome 6 Brands" !important;
            font-weight: 400 !important;
        }

        .fas::before {
            font-family: "Font Awesome 6 Free" !important;
            font-weight: 900 !important;
        }

        /* Mobile responsiveness for contact cards */
        @media (max-width: 767px) {
            .contact-option-card {
                margin-bottom: 2rem;
            }
            
            .contact-icon {
                font-size: 2.5rem;
            }
            
            .social-links-hero h5 {
                text-align: center;
            }
        }

        /* Loading animation for when icons are loading */
        .contact-icon, .social-btn i {
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
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
                                <a href="https://www.linkedin.com/in/ariyan-aftab?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app" class="social-btn linkedin" target="_blank" rel="noopener noreferrer">
                                    <i class="fab fa-linkedin-in"></i>
                                    <span>LinkedIn</span>
                                </a>
                                <a href="https://github.com/redphoenix-05" class="social-btn github" target="_blank" rel="noopener noreferrer">
                                    <i class="fab fa-github"></i>
                                    <span>GitHub</span>
                                </a>
                                <a href="https://www.instagram.com/ariyan_spandan?igsh=MTNxeHZ5bnN6bWJ5bg==" class="social-btn instagram" target="_blank" rel="noopener noreferrer">
                                    <i class="fab fa-instagram"></i>
                                    <span>Instagram</span>
                                </a>
                                <a href="https://www.facebook.com/share/17N4rZ18xk/" class="social-btn facebook" target="_blank" rel="noopener noreferrer">
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
                                
                                <!-- Validation Summary (Only shown on submit) -->
                                <div id="validationSummary" class="alert alert-warning" style="display: none;">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    <strong>Please fix the following errors:</strong>
                                    <ul id="validationList" class="mb-0 mt-2"></ul>
                                </div>
                                
                                <!-- Contact Form -->
                                <div class="form-group mb-3">
                                    <label for="txtName" class="form-label">
                                        <i class="fas fa-user me-2"></i>Full Name
                                    </label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control form-control-hero" 
                                                placeholder="Enter your full name" MaxLength="100" />
                                    <div class="invalid-feedback" id="nameError" style="display: none;">
                                        Name is required
                                    </div>
                                </div>
                                
                                <div class="form-group mb-3">
                                    <label for="txtEmail" class="form-label">
                                        <i class="fas fa-envelope me-2"></i>Email Address
                                    </label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control form-control-hero" 
                                                TextMode="Email" placeholder="Enter your email address" MaxLength="100" />
                                    <div class="invalid-feedback" id="emailError" style="display: none;">
                                        Please enter a valid email address
                                    </div>
                                </div>
                                
                                <div class="form-group mb-3">
                                    <label for="txtPhone" class="form-label">
                                        <i class="fas fa-phone me-2"></i>Phone Number
                                    </label>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control form-control-hero" 
                                                placeholder="Enter your phone number (optional)" MaxLength="20" />
                                    <div class="invalid-feedback" id="phoneError" style="display: none;">
                                        Please enter a valid phone number
                                    </div>
                                </div>
                                
                                <div class="form-group mb-4">
                                    <label for="txtMessage" class="form-label">
                                        <i class="fas fa-comment me-2"></i>Message
                                    </label>
                                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control form-control-hero" 
                                                TextMode="MultiLine" Rows="5" 
                                                placeholder="Tell me about your project or inquiry..." MaxLength="1000" />
                                    <div class="invalid-feedback" id="messageError" style="display: none;">
                                        Message is required
                                    </div>
                                </div>
                                
                                <div class="form-group text-center">
                                    <asp:Button ID="btnSendMessage" runat="server" CssClass="btn btn-hero btn-lg w-100" 
                                               Text="Send Message" OnClick="btnSendMessage_Click" 
                                               OnClientClick="return validateForm();" />
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
                        <a href="https://wa.me/1234567890" class="btn btn-outline-success btn-sm" target="_blank" rel="noopener noreferrer">
                            <i class="fab fa-whatsapp me-1"></i>Message
                        </a>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card contact-option-card">
                        <div class="contact-icon">
                            <i class="fab fa-linkedin-in"></i>
                        </div>
                        <h5>LinkedIn</h5>
                        <p>Professional networking and connections</p>
                        <a href="https://www.linkedin.com/in/ariyan-aftab?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app" class="btn btn-outline-primary btn-sm" target="_blank" rel="noopener noreferrer">
                            <i class="fab fa-linkedin-in me-1"></i>Connect
                        </a>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card contact-option-card">
                        <div class="contact-icon">
                            <i class="fab fa-github"></i>
                        </div>
                        <h5>GitHub</h5>
                        <p>Explore my code repositories and projects</p>
                        <a href="https://github.com/redphoenix-05" class="btn btn-outline-dark btn-sm" target="_blank" rel="noopener noreferrer">
                            <i class="fab fa-github me-1"></i>View Profile
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Additional Social Media Row -->
            <div class="row text-center mt-4">
                <div class="col-md-6 mb-4">
                    <div class="stat-card contact-option-card">
                        <div class="contact-icon">
                            <i class="fab fa-instagram"></i>
                        </div>
                        <h5>Instagram</h5>
                        <p>Follow for behind-the-scenes content and updates</p>
                        <a href="https://www.instagram.com/ariyan_spandan?igsh=MTNxeHZ5bnN6bWJ5bg==" class="btn btn-outline-danger btn-sm" target="_blank" rel="noopener noreferrer">
                            <i class="fab fa-instagram me-1"></i>Follow
                        </a>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="stat-card contact-option-card">
                        <div class="contact-icon">
                            <i class="fab fa-facebook-f"></i>
                        </div>
                        <h5>Facebook</h5>
                        <p>Connect and stay updated with my latest work</p>
                        <a href="https://www.facebook.com/share/17N4rZ18xk/" class="btn btn-outline-primary btn-sm" target="_blank" rel="noopener noreferrer">
                            <i class="fab fa-facebook-f me-1"></i>Connect
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
                    // Clear validation styling when user starts typing
                    this.classList.remove('is-invalid');
                    const errorElement = this.parentElement.querySelector('.invalid-feedback');
                    if (errorElement) {
                        errorElement.style.display = 'none';
                    }
                });
                
                input.addEventListener('blur', function() {
                    if (this.value === '') {
                        this.parentElement.classList.remove('focused');
                    }
                });
            });
        });

        // Custom validation function that only runs on submit
        function validateForm() {
            // Hide any previous validation messages
            hideValidationMessages();
            
            const nameField = document.getElementById('<%= txtName.ClientID %>');
            const emailField = document.getElementById('<%= txtEmail.ClientID %>');
            const phoneField = document.getElementById('<%= txtPhone.ClientID %>');
            const messageField = document.getElementById('<%= txtMessage.ClientID %>');
            const submitBtn = document.getElementById('<%= btnSendMessage.ClientID %>');
            
            let isValid = true;
            const errors = [];
            
            // Validate Name (required)
            if (!nameField.value.trim()) {
                showFieldError(nameField, 'nameError', 'Name is required');
                errors.push('Name is required');
                isValid = false;
            }
            
            // Validate Email (required and format)
            const emailValue = emailField.value.trim();
            if (!emailValue) {
                showFieldError(emailField, 'emailError', 'Email is required');
                errors.push('Email is required');
                isValid = false;
            } else if (!isValidEmail(emailValue)) {
                showFieldError(emailField, 'emailError', 'Please enter a valid email address');
                errors.push('Please enter a valid email address');
                isValid = false;
            }
            
            // Validate Phone (optional but format check if provided)
            const phoneValue = phoneField.value.trim();
            if (phoneValue && !isValidPhone(phoneValue)) {
                showFieldError(phoneField, 'phoneError', 'Please enter a valid phone number');
                errors.push('Please enter a valid phone number');
                isValid = false;
            }
            
            // Validate Message (required)
            if (!messageField.value.trim()) {
                showFieldError(messageField, 'messageError', 'Message is required');
                errors.push('Message is required');
                isValid = false;
            }
            
            // Show validation summary if there are errors
            if (!isValid) {
                showValidationSummary(errors);
                return false; // Prevent form submission
            }
            
            // If validation passes, show loading state
            if (isValid) {
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Sending...';
                submitBtn.disabled = true;
            }
            
            return isValid;
        }
        
        function showFieldError(field, errorId, message) {
            field.classList.add('is-invalid');
            const errorElement = document.getElementById(errorId);
            if (errorElement) {
                errorElement.textContent = message;
                errorElement.style.display = 'block';
            }
        }
        
        function hideValidationMessages() {
            // Hide validation summary
            const validationSummary = document.getElementById('validationSummary');
            if (validationSummary) {
                validationSummary.style.display = 'none';
            }
            
            // Hide individual field errors
            const fields = ['<%= txtName.ClientID %>', '<%= txtEmail.ClientID %>', '<%= txtPhone.ClientID %>', '<%= txtMessage.ClientID %>'];
            const errorIds = ['nameError', 'emailError', 'phoneError', 'messageError'];
            
            fields.forEach((fieldId, index) => {
                const field = document.getElementById(fieldId);
                const errorElement = document.getElementById(errorIds[index]);
                
                if (field) {
                    field.classList.remove('is-invalid');
                }
                if (errorElement) {
                    errorElement.style.display = 'none';
                }
            });
        }
        
        function showValidationSummary(errors) {
            const validationSummary = document.getElementById('validationSummary');
            const validationList = document.getElementById('validationList');
            
            if (validationSummary && validationList) {
                validationList.innerHTML = errors.map(error => `<li>${error}</li>`).join('');
                validationSummary.style.display = 'block';
                
                // Scroll to validation summary
                validationSummary.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }
        
        function isValidEmail(email) {
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            return emailRegex.test(email);
        }
        
        function isValidPhone(phone) {
            const phoneRegex = /^[\+]?[0-9\s\-\(\)]{10,20}$/;
            return phoneRegex.test(phone);
        }
    </script>
</asp:Content>