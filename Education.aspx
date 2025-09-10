<%@ Page Title="Education" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Education.aspx.cs" Inherits="WebApplication1.Education" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Explore Ariyan Aftab Spandan's educational background and academic achievements." />
    <meta name="keywords" content="education, academic background, qualifications, degrees, Ariyan Aftab Spandan" />
    <style>
        .education-timeline {
            position: relative;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .education-timeline::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            width: 4px;
            height: 100%;
            background: var(--primary-gradient);
            transform: translateX(-50%);
            border-radius: 2px;
            box-shadow: 0 0 20px rgba(37, 99, 235, 0.3);
        }
        
        .education-item {
            position: relative;
            margin: 3rem 0;
            opacity: 0;
            transform: translateY(50px);
            animation: fadeInUp 0.6s ease forwards;
        }
        
        .education-item:nth-child(1) { animation-delay: 0.1s; }
        .education-item:nth-child(2) { animation-delay: 0.3s; }
        .education-item:nth-child(3) { animation-delay: 0.5s; }
        .education-item:nth-child(4) { animation-delay: 0.7s; }
        
        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .education-content {
            background: var(--base-white);
            padding: 2rem;
            border-radius: 12px;
            box-shadow: var(--shadow-heavy);
            border: 1px solid rgba(37, 99, 235, 0.1);
            transition: var(--transition-medium);
            position: relative;
            width: 45%;
            margin-left: 55%;
        }
        
        .education-item:nth-child(even) .education-content {
            margin-left: 0;
            margin-right: 55%;
        }
        
        .education-content:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-glow);
            border-color: var(--secondary-teal);
        }
        
        .education-content::before {
            content: '';
            position: absolute;
            top: 50%;
            width: 0;
            height: 0;
            border: 20px solid transparent;
            transform: translateY(-50%);
        }
        
        .education-content::before {
            left: -40px;
            border-right-color: var(--base-white);
        }
        
        .education-item:nth-child(even) .education-content::before {
            left: auto;
            right: -40px;
            border-right-color: transparent;
            border-left-color: var(--base-white);
        }
        
        .education-year {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            background: var(--primary-gradient);
            color: var(--base-white);
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: 600;
            box-shadow: var(--shadow-medium);
            z-index: 10;
            min-width: 100px;
            text-align: center;
        }
        
        .education-degree {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }
        
        .education-institution {
            font-size: 1.1rem;
            color: var(--secondary-teal);
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        .education-details {
            margin-bottom: 1rem;
        }
        
        .education-grade {
            background: var(--accent-gradient);
            color: var(--primary-blue);
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 0.5rem;
        }
        
        .education-location {
            color: var(--text-secondary);
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        @media (max-width: 768px) {
            .education-timeline::before {
                left: 20px;
            }
            
            .education-content {
                width: calc(100% - 60px);
                margin-left: 60px !important;
                margin-right: 0 !important;
            }
            
            .education-content::before {
                left: -40px !important;
                border-right-color: var(--base-white) !important;
                border-left-color: transparent !important;
            }
            
            .education-year {
                left: 20px;
                transform: translate(-50%, -50%);
            }
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Education Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center position-relative">
                <!-- Central Dividing Line -->
                <div class="hero-divider"></div>
                
                <!-- Left Side - Education Information -->
                <div class="col-lg-6 hero-left">
                    <div class="hero-content fade-in">
                        <h1 class="hero-title">Education</h1>
                        <p class="hero-tagline">Academic Journey & Learning Path</p>
                        <div class="hero-description">
                            <p>My educational background spans various levels of academic excellence, building a strong foundation in computer science and technology.</p>
                            <p>Each milestone represents dedication to learning and continuous growth in the field of software development.</p>
                        </div>
                        <div class="hero-buttons">
                            <a href="Skills.aspx" class="btn btn-hero btn-lg btn-custom me-3">
                                <i class="fas fa-cogs me-2"></i>View Skills
                            </a>
                            <a href="Achievements.aspx" class="btn btn-hero-outline btn-lg btn-custom">
                                <i class="fas fa-trophy me-2"></i>See Achievements
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Right Side - Education Visual -->
                <div class="col-lg-6 hero-right text-center">
                    <div class="slide-up">
                        <div class="profile-container">
                            <div class="education-visual-hero">
                                <div class="education-icons-grid">
                                    <div class="education-icon-card">
                                        <i class="fas fa-graduation-cap"></i>
                                        <span>Bachelor's</span>
                                    </div>
                                    <div class="education-icon-card">
                                        <i class="fas fa-university"></i>
                                        <span>University</span>
                                    </div>
                                    <div class="education-icon-card">
                                        <i class="fas fa-medal"></i>
                                        <span>High GPA</span>
                                    </div>
                                    <div class="education-icon-card">
                                        <i class="fas fa-book"></i>
                                        <span>CS Major</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Education Timeline Section -->
    <section class="py-5 skills-section">
        <div class="container">
            <h2 class="section-title">Educational Timeline</h2>
            <div class="education-timeline" id="educationTimeline">
                <!-- Dynamic education content will be loaded here -->
            </div>
        </div>
    </section>

    <!-- Education Statistics -->
    <section class="py-5 services-section">
        <div class="container">
            <h2 class="section-title">Academic Statistics</h2>
            <div class="row text-center">
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="3">0</h3>
                        <p class="stat-label">Degrees Completed</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="4">0</h3>
                        <p class="stat-label">Years of Study</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="385">0</h3>
                        <p class="stat-label">Average GPA (x100)</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <h3 class="stat-number" data-count="12">0</h3>
                        <p class="stat-label">Major Subjects</p>
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