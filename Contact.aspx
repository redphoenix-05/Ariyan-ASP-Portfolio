<%@ Page Title="Contact Me" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="WebApplication1.Contact" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Get in touch with me for opportunities, collaborations, or just to say hello!" />
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Contact Hero Section -->
    <section class="py-5 bg-primary text-white">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-4 fw-bold mb-3">Get In Touch</h1>
                    <p class="lead">Ready to start a conversation? I'd love to hear from you.</p>
                </div>
                <div class="col-lg-4 text-center">
                    <i class="fas fa-envelope fa-5x"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Content Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <!-- Contact Form -->
                <div class="col-lg-8">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white">
                            <h3 class="mb-0"><i class="fas fa-paper-plane me-2"></i>Send Me a Message</h3>
                        </div>
                        <div class="card-body">
                            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="mb-4">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>
                                    <asp:Literal ID="litMessage" runat="server" />
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </asp:Panel>

                            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="mb-4">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    <asp:Literal ID="litError" runat="server" />
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </asp:Panel>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtName.ClientID %>" class="form-label">Full Name *</label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" 
                                                placeholder="Your full name" MaxLength="100" />
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" 
                                                              ControlToValidate="txtName" 
                                                              ErrorMessage="Name is required"
                                                              CssClass="text-danger small"
                                                              Display="Dynamic" />
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtEmail.ClientID %>" class="form-label">Email Address *</label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" 
                                                TextMode="Email" placeholder="your.email@example.com" MaxLength="200" />
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                                              ControlToValidate="txtEmail" 
                                                              ErrorMessage="Email is required"
                                                              CssClass="text-danger small"
                                                              Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                                                                  ControlToValidate="txtEmail"
                                                                  ErrorMessage="Please enter a valid email address"
                                                                  ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                                                  CssClass="text-danger small"
                                                                  Display="Dynamic" />
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="<%= txtSubject.ClientID %>" class="form-label">Subject</label>
                                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" 
                                            placeholder="What's this about?" MaxLength="300" />
                            </div>
                            
                            <div class="mb-4">
                                <label for="<%= txtMessage.ClientID %>" class="form-label">Message *</label>
                                <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" 
                                            TextMode="MultiLine" Rows="6" 
                                            placeholder="Tell me more about your project, question, or just say hello!" />
                                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" 
                                                          ControlToValidate="txtMessage" 
                                                          ErrorMessage="Message is required"
                                                          CssClass="text-danger small"
                                                          Display="Dynamic" />
                            </div>
                            
                            <div class="d-grid">
                                <asp:Button ID="btnSend" runat="server" Text="Send Message" 
                                           CssClass="btn btn-primary btn-lg btn-custom"
                                           OnClick="btnSend_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contact Information Sidebar -->
                <div class="col-lg-4">
                    <div class="contact-info mb-4">
                        <h4 class="text-white mb-4">
                            <i class="fas fa-info-circle me-2"></i>Contact Information
                        </h4>
                        
                        <div class="contact-item mb-3" runat="server" id="divContactEmail" visible="false">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-envelope fa-lg me-3"></i>
                                <div>
                                    <h6 class="mb-1 text-white">Email</h6>
                                    <asp:Literal ID="litContactEmail" runat="server" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="contact-item mb-3" runat="server" id="divContactPhone" visible="false">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-phone fa-lg me-3"></i>
                                <div>
                                    <h6 class="mb-1 text-white">Phone</h6>
                                    <asp:Literal ID="litContactPhone" runat="server" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="contact-item mb-4" runat="server" id="divContactAddress" visible="false">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-map-marker-alt fa-lg me-3"></i>
                                <div>
                                    <h6 class="mb-1 text-white">Location</h6>
                                    <asp:Literal ID="litContactAddress" runat="server" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="social-links">
                            <h6 class="text-white mb-3">Follow Me</h6>
                            <div class="d-flex gap-2">
                                <asp:HyperLink ID="lnkContactLinkedIn" runat="server" 
                                              CssClass="btn btn-outline-light btn-sm" 
                                              Visible="false" Target="_blank">
                                    <i class="fab fa-linkedin"></i>
                                </asp:HyperLink>
                                <asp:HyperLink ID="lnkContactGitHub" runat="server" 
                                              CssClass="btn btn-outline-light btn-sm" 
                                              Visible="false" Target="_blank">
                                    <i class="fab fa-github"></i>
                                </asp:HyperLink>
                                <asp:HyperLink ID="lnkContactTwitter" runat="server" 
                                              CssClass="btn btn-outline-light btn-sm" 
                                              Visible="false" Target="_blank">
                                    <i class="fab fa-twitter"></i>
                                </asp:HyperLink>
                                <asp:HyperLink ID="lnkContactFacebook" runat="server" 
                                              CssClass="btn btn-outline-light btn-sm" 
                                              Visible="false" Target="_blank">
                                    <i class="fab fa-facebook"></i>
                                </asp:HyperLink>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Tips Card -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-lightbulb me-2"></i>Quick Tips</h5>
                        </div>
                        <div class="card-body">
                            <ul class="list-unstyled mb-0">
                                <li class="mb-2">
                                    <i class="fas fa-check text-success me-2"></i>
                                    Be specific about your project requirements
                                </li>
                                <li class="mb-2">
                                    <i class="fas fa-check text-success me-2"></i>
                                    Include your timeline and budget if applicable
                                </li>
                                <li class="mb-2">
                                    <i class="fas fa-check text-success me-2"></i>
                                    Mention your preferred communication method
                                </li>
                                <li class="mb-0">
                                    <i class="fas fa-check text-success me-2"></i>
                                    I typically respond within 24 hours
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQ Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <h2 class="section-title">Frequently Asked Questions</h2>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="accordion" id="faqAccordion">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" 
                                        data-bs-target="#faq1" aria-expanded="true" aria-controls="faq1">
                                    How quickly do you respond to messages?
                                </button>
                            </h2>
                            <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    I aim to respond to all messages within 24 hours during business days. 
                                    For urgent matters, please mention it in your subject line.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                        data-bs-target="#faq2" aria-expanded="false" aria-controls="faq2">
                                    What types of projects do you work on?
                                </button>
                            </h2>
                            <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    I specialize in web development projects including custom web applications, 
                                    e-commerce sites, portfolio websites, and database-driven applications using 
                                    ASP.NET, C#, and modern web technologies.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                        data-bs-target="#faq3" aria-expanded="false" aria-controls="faq3">
                                    Do you provide ongoing support and maintenance?
                                </button>
                            </h2>
                            <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    Yes, I offer ongoing support and maintenance packages for projects I develop. 
                                    This includes bug fixes, updates, security patches, and feature enhancements.
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
            // Auto-hide alerts after 5 seconds
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);

            // Form validation enhancement
            const form = document.querySelector('form');
            const submitBtn = document.getElementById('<%= btnSend.ClientID %>');
            
            if (form && submitBtn) {
                form.addEventListener('submit', function(e) {
                    if (this.checkValidity()) {
                        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Sending...';
                        submitBtn.disabled = true;
                    }
                });
            }
        });
    </script>
</asp:Content>