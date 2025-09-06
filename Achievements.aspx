<%@ Page Title="Achievements & Certifications" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Achievements.aspx.cs" Inherits="WebApplication1.Achievements" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Explore Ariyan Aftab Spandan's achievements, certifications, and recognitions in software development." />
    <meta name="keywords" content="achievements, certifications, awards, recognitions, Ariyan Aftab Spandan" />
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Achievements Hero Section -->
    <section class="about-hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-12 text-center">
                    <div class="about-content">
                        <h1 class="about-title">Achievements & Certifications</h1>
                        <p class="about-tagline">Recognition & Professional Development</p>
                        <div class="about-description">
                            <p>A collection of my professional achievements, certifications, and recognitions that demonstrate my commitment to continuous learning and excellence in software development.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Certifications Section -->
    <section class="py-5 skills-section">
        <div class="container">
            <h2 class="section-title">Professional Certifications</h2>
            <div class="row">
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100 certificate-card">
                        <img src="~/Images/certificates/certificate1.jpg" class="card-img-top" alt="Microsoft Azure Certification" 
                             onerror="this.src='https://via.placeholder.com/500x300/007bff/ffffff?text=Microsoft+Azure+Fundamentals'">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">Microsoft Azure Fundamentals</h5>
                                <span class="badge bg-primary">AZ-900</span>
                            </div>
                            <p class="card-text">Foundational knowledge of cloud services and how those services are provided with Microsoft Azure.</p>
                            
                            <div class="cert-details mb-3">
                                <div class="row">
                                    <div class="col-6">
                                        <small class="text-muted">
                                            <strong>Issued:</strong> January 2024
                                        </small>
                                    </div>
                                    <div class="col-6">
                                        <small class="text-muted">
                                            <strong>Expires:</strong> January 2027
                                        </small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="skills-covered mb-3">
                                <h6 class="mb-2">Skills Covered:</h6>
                                <div class="d-flex flex-wrap gap-1">
                                    <span class="badge bg-info">Cloud Computing</span>
                                    <span class="badge bg-success">Azure Services</span>
                                    <span class="badge bg-warning">Security</span>
                                    <span class="badge bg-secondary">Pricing</span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-primary btn-sm">
                                    <i class="fas fa-certificate me-1"></i>View Certificate
                                </a>
                                <a href="#" class="btn btn-primary btn-sm">
                                    <i class="fas fa-external-link-alt me-1"></i>Verify
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100 certificate-card">
                        <img src="~/Images/certificates/certificate2.jpg" class="card-img-top" alt="Google Associate Android Developer" 
                             onerror="this.src='https://via.placeholder.com/500x300/28a745/ffffff?text=Google+Associate+Android+Developer'">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">Associate Android Developer</h5>
                                <span class="badge bg-success">Google</span>
                            </div>
                            <p class="card-text">Demonstrates proficiency in Android development skills and best practices for building Android applications.</p>
                            
                            <div class="cert-details mb-3">
                                <div class="row">
                                    <div class="col-6">
                                        <small class="text-muted">
                                            <strong>Issued:</strong> November 2023
                                        </small>
                                    </div>
                                    <div class="col-6">
                                        <small class="text-muted">
                                            <strong>Status:</strong> Valid
                                        </small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="skills-covered mb-3">
                                <h6 class="mb-2">Skills Covered:</h6>
                                <div class="d-flex flex-wrap gap-1">
                                    <span class="badge bg-success">Android SDK</span>
                                    <span class="badge bg-info">Kotlin</span>
                                    <span class="badge bg-warning">UI/UX</span>
                                    <span class="badge bg-secondary">Testing</span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-success btn-sm">
                                    <i class="fas fa-certificate me-1"></i>View Certificate
                                </a>
                                <a href="#" class="btn btn-success btn-sm">
                                    <i class="fas fa-external-link-alt me-1"></i>Verify
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100 certificate-card">
                        <img src="~/Images/certificates/certificate3.jpg" class="card-img-top" alt="AWS Cloud Practitioner" 
                             onerror="this.src='https://via.placeholder.com/500x300/ff9900/ffffff?text=AWS+Cloud+Practitioner'">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">AWS Cloud Practitioner</h5>
                                <span class="badge bg-warning">CLF-C01</span>
                            </div>
                            <p class="card-text">Foundational understanding of AWS Cloud concepts, services, and terminology.</p>
                            
                            <div class="cert-details mb-3">
                                <div class="row">
                                    <div class="col-6">
                                        <small class="text-muted">
                                            <strong>Issued:</strong> September 2023
                                        </small>
                                    </div>
                                    <div class="col-6">
                                        <small class="text-muted">
                                            <strong>Expires:</strong> September 2026
                                        </small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="skills-covered mb-3">
                                <h6 class="mb-2">Skills Covered:</h6>
                                <div class="d-flex flex-wrap gap-1">
                                    <span class="badge bg-warning">AWS Services</span>
                                    <span class="badge bg-info">Cloud Architecture</span>
                                    <span class="badge bg-success">Security</span>
                                    <span class="badge bg-secondary">Billing</span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-warning btn-sm">
                                    <i class="fas fa-certificate me-1"></i>View Certificate
                                </a>
                                <a href="#" class="btn btn-warning btn-sm">
                                    <i class="fas fa-external-link-alt me-1"></i>Verify
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100 certificate-card">
                        <img src="~/Images/certificates/certificate4.jpg" class="card-img-top" alt="React Developer Certification" 
                             onerror="this.src='https://via.placeholder.com/500x300/61dafb/000000?text=React+Developer+Certification'">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">React Developer Certification</h5>
                                <span class="badge bg-info">Meta</span>
                            </div>
                            <p class="card-text">Advanced React development skills including hooks, context API, and modern React patterns.</p>
                            
                            <div class="cert-details mb-3">
                                <div class="row">
                                    <div class="col-6">
                                        <small class="text-muted">
                                            <strong>Issued:</strong> August 2023
                                        </small>
                                    </div>
                                    <div class="col-6">
                                        <small class="text-muted">
                                            <strong>Status:</strong> Valid
                                        </small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="skills-covered mb-3">
                                <h6 class="mb-2">Skills Covered:</h6>
                                <div class="d-flex flex-wrap gap-1">
                                    <span class="badge bg-info">React.js</span>
                                    <span class="badge bg-warning">JSX</span>
                                    <span class="badge bg-success">Hooks</span>
                                    <span class="badge bg-secondary">Redux</span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <a href="#" class="btn btn-outline-info btn-sm">
                                    <i class="fas fa-certificate me-1"></i>View Certificate
                                </a>
                                <a href="#" class="btn btn-info btn-sm">
                                    <i class="fas fa-external-link-alt me-1"></i>Verify
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Achievements Section -->
    <section class="py-5 services-section">
        <div class="container">
            <h2 class="section-title">Awards & Achievements</h2>
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card achievement-card">
                        <div class="service-icon">
                            <i class="fas fa-trophy"></i>
                        </div>
                        <h5>Best Mobile App Developer</h5>
                        <p class="text-muted">University Tech Competition 2023</p>
                        <p>Awarded for developing an innovative mobile application with outstanding user experience and technical implementation.</p>
                        <div class="achievement-date">
                            <small class="text-muted">
                                <i class="fas fa-calendar me-1"></i>March 2023
                            </small>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card achievement-card">
                        <div class="service-icon">
                            <i class="fas fa-medal"></i>
                        </div>
                        <h5>Dean's List Honor Roll</h5>
                        <p class="text-muted">Academic Excellence 2022-2023</p>
                        <p>Recognized for maintaining exceptional academic performance throughout the academic year with GPA above 3.8.</p>
                        <div class="achievement-date">
                            <small class="text-muted">
                                <i class="fas fa-calendar me-1"></i>May 2023
                            </small>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card achievement-card">
                        <div class="service-icon">
                            <i class="fas fa-award"></i>
                        </div>
                        <h5>Hackathon Winner</h5>
                        <p class="text-muted">Regional Tech Hackathon 2023</p>
                        <p>First place winner for developing a real-time collaborative platform within 48 hours with innovative features.</p>
                        <div class="achievement-date">
                            <small class="text-muted">
                                <i class="fas fa-calendar me-1"></i>October 2023
                            </small>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card achievement-card">
                        <div class="service-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <h5>Student Developer Program</h5>
                        <p class="text-muted">Google Developer Student Clubs</p>
                        <p>Selected as a core team member and mentor for junior developers in mobile and web development technologies.</p>
                        <div class="achievement-date">
                            <small class="text-muted">
                                <i class="fas fa-calendar me-1"></i>September 2022
                            </small>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card achievement-card">
                        <div class="service-icon">
                            <i class="fas fa-code"></i>
                        </div>
                        <h5>Open Source Contributor</h5>
                        <p class="text-muted">GitHub Recognition 2023</p>
                        <p>Recognized for significant contributions to open source projects with over 100+ pull requests merged.</p>
                        <div class="achievement-date">
                            <small class="text-muted">
                                <i class="fas fa-calendar me-1"></i>December 2023
                            </small>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-card achievement-card">
                        <div class="service-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5>Tech Community Leader</h5>
                        <p class="text-muted">Local Developer Community</p>
                        <p>Led workshops and mentoring sessions for aspiring developers, helping 50+ students learn programming.</p>
                        <div class="achievement-date">
                            <small class="text-muted">
                                <i class="fas fa-calendar me-1"></i>Ongoing
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Skills & Competencies Recognition -->
    <section class="py-5 skills-section">
        <div class="container">
            <h2 class="section-title">Skills & Competencies Recognition</h2>
            <div class="row">
                <div class="col-lg-6 mb-4">
                    <div class="skills-container">
                        <h4 class="skills-category-title">
                            <i class="fas fa-certificate me-2"></i>Technical Certifications
                        </h4>
                        <div class="list-group list-group-flush">
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                Microsoft Azure Fundamentals (AZ-900)
                                <span class="badge bg-primary rounded-pill">2024</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                Google Associate Android Developer
                                <span class="badge bg-success rounded-pill">2023</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                AWS Cloud Practitioner (CLF-C01)
                                <span class="badge bg-warning rounded-pill">2023</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                Meta React Developer Certification
                                <span class="badge bg-info rounded-pill">2023</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                Oracle Java SE Programmer
                                <span class="badge bg-danger rounded-pill">2022</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6 mb-4">
                    <div class="skills-container">
                        <h4 class="skills-category-title">
                            <i class="fas fa-trophy me-2"></i>Awards & Recognition
                        </h4>
                        <div class="list-group list-group-flush">
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                Best Mobile App Developer
                                <span class="badge bg-primary rounded-pill">2023</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                Hackathon Winner - 1st Place
                                <span class="badge bg-success rounded-pill">2023</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                Dean's List Honor Roll
                                <span class="badge bg-warning rounded-pill">2023</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                Student Developer Program
                                <span class="badge bg-info rounded-pill">2022</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                Community Leadership Award
                                <span class="badge bg-danger rounded-pill">2023</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Achievement Statistics -->
    <section class="py-5 services-section">
        <div class="container">
            <h2 class="section-title">Achievement Statistics</h2>
            <div class="row text-center">
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="12">0</h3>
                        <p class="stat-label">Certifications</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="8">0</h3>
                        <p class="stat-label">Awards</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="5">0</h3>
                        <p class="stat-label">Hackathon Wins</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="50">0</h3>
                        <p class="stat-label">Students Mentored</p>
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