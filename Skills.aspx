<%@ Page Title="Technical Skills" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Skills.aspx.cs" Inherits="WebApplication1.Skills" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Explore Ariyan Aftab Spandan's technical skills, programming languages, frameworks, and technologies." />
    <meta name="keywords" content="skills, programming languages, frameworks, technologies, Ariyan Aftab Spandan" />
    <style>
        .skill-card {
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .skill-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        .skill-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .progress {
            height: 12px;
            background-color: #e9ecef;
            border-radius: 6px;
        }
        
        .progress-bar {
            transition: width 2s ease-in-out;
            border-radius: 6px;
            background: linear-gradient(45deg, #667eea, #764ba2);
        }
        
        .progress-bar-animated {
            animation: progress-bar-stripes 1s linear infinite;
        }
        
        .skill-category-filter {
            margin-bottom: 2rem;
        }
        
        .filter-btn {
            margin: 0.25rem;
            border-radius: 25px;
            padding: 0.5rem 1.5rem;
            transition: all 0.3s ease;
        }
        
        .filter-btn.active {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-color: #667eea;
            color: white;
        }
        
        .skills-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 0;
            margin-bottom: 3rem;
        }
        
        .skills-hero h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .skills-hero .lead {
            font-size: 1.25rem;
            margin-bottom: 2rem;
        }
        
        .stats-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            backdrop-filter: blur(10px);
        }
        
        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #fff;
        }
        
        .stats-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- Skills Hero Section -->
    <section class="skills-hero">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="mb-4">Technical Skills & Expertise</h1>
                    <p class="lead">A comprehensive overview of my technical capabilities, programming languages, frameworks, and tools that I use to bring ideas to life.</p>
                    <p class="mb-4">Each skill represents hands-on experience and continuous learning in the ever-evolving world of technology.</p>
                </div>
                <div class="col-lg-4">
                    <div class="row">
                        <div class="col-6 mb-3">
                            <div class="stats-card">
                                <div class="stats-number" id="totalSkills">0</div>
                                <div class="stats-label">Total Skills</div>
                            </div>
                        </div>
                        <div class="col-6 mb-3">
                            <div class="stats-card">
                                <div class="stats-number" id="avgProficiency">0%</div>
                                <div class="stats-label">Avg Proficiency</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stats-card">
                                <div class="stats-number" id="categories">0</div>
                                <div class="stats-label">Categories</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stats-card">
                                <div class="stats-number" id="expertSkills">0</div>
                                <div class="stats-label">Expert Level</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Skills Filter Section -->
    <section class="container mb-5">
        <div class="skill-category-filter text-center">
            <h3 class="mb-4">Filter by Category</h3>
            <button class="btn btn-outline-primary filter-btn active" onclick="filterSkills('all')">All Skills</button>
            <button class="btn btn-outline-primary filter-btn" onclick="filterSkills('programming')">Programming</button>
            <button class="btn btn-outline-primary filter-btn" onclick="filterSkills('framework')">Frameworks</button>
            <button class="btn btn-outline-primary filter-btn" onclick="filterSkills('mobile')">Mobile</button>
            <button class="btn btn-outline-primary filter-btn" onclick="filterSkills('database')">Database</button>
            <button class="btn btn-outline-primary filter-btn" onclick="filterSkills('technology')">Technology</button>
        </div>
    </section>

    <!-- Skills Grid Section -->
    <section class="container skills-section mb-5">
        <div class="skills-container">
            <div class="row">
                <!-- Skills will be dynamically loaded here by the code-behind -->
                <div class="col-12 text-center py-5">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading skills...</span>
                    </div>
                    <p class="mt-3 text-muted">Loading skills from database...</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Skills Summary Section -->
    <section class="container mb-5">
        <div class="row">
            <div class="col-12">
                <div class="card bg-light">
                    <div class="card-body text-center py-5">
                        <h3 class="mb-4">Continuous Learning Journey</h3>
                        <p class="lead mb-4">Technology never stops evolving, and neither do I. I'm constantly learning new technologies and improving my existing skills.</p>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <i class="fas fa-code fa-3x text-primary mb-3"></i>
                                <h5>Clean Code</h5>
                                <p class="text-muted">Writing maintainable, readable, and efficient code following best practices.</p>
                            </div>
                            <div class="col-md-4 mb-3">
                                <i class="fas fa-rocket fa-3x text-success mb-3"></i>
                                <h5>Performance</h5>
                                <p class="text-muted">Optimizing applications for speed, scalability, and user experience.</p>
                            </div>
                            <div class="col-md-4 mb-3">
                                <i class="fas fa-shield-alt fa-3x text-warning mb-3"></i>
                                <h5>Security</h5>
                                <p class="text-muted">Implementing security best practices and secure coding standards.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="container mb-5">
        <div class="row">
            <div class="col-12 text-center">
                <div class="bg-primary text-white p-5 rounded">
                    <h3 class="mb-4">Ready to Collaborate?</h3>
                    <p class="lead mb-4">Let's work together to bring your ideas to life using these technologies and more.</p>
                    <div class="d-flex justify-content-center gap-3 flex-wrap">
                        <a href="Projects.aspx" class="btn btn-light btn-lg">
                            <i class="fas fa-folder-open me-2"></i>View My Projects
                        </a>
                        <a href="Contact.aspx" class="btn btn-outline-light btn-lg">
                            <i class="fas fa-envelope me-2"></i>Get In Touch
                        </a>
                        <a href="About.aspx" class="btn btn-outline-light btn-lg">
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
        // Global variables to track skills
        let skillsLoaded = false;
        
        document.addEventListener('DOMContentLoaded', function() {
            // Wait for skills to be loaded before initializing filters
            const checkSkillsLoaded = setInterval(() => {
                const skillCards = document.querySelectorAll('[data-category]');
                if (skillCards.length > 0) {
                    skillsLoaded = true;
                    clearInterval(checkSkillsLoaded);
                    
                    // Initialize everything after skills are loaded
                    initializeSkillFilters();
                    calculateSkillsStats();
                    addSkillCardEffects();
                }
            }, 100);
        });

        // This function will be called from the injected script after skills are loaded
        function initializeSkillFilters() {
            console.log('Initializing skill filters...');
            
            const filterButtons = document.querySelectorAll('.filter-btn');
            console.log('Found filter buttons:', filterButtons.length);
            
            filterButtons.forEach((button, index) => {
                console.log(`Button ${index}:`, button.textContent, button.getAttribute('onclick'));
                
                // Remove existing event listeners to avoid duplicates
                button.removeEventListener('click', handleFilterClick);
                button.addEventListener('click', handleFilterClick);
            });
            
            // Debug: List all skill containers and their categories
            const skillContainers = document.querySelectorAll('[data-category]');
            console.log('Found skill containers:', skillContainers.length);
            skillContainers.forEach((container, index) => {
                console.log(`Skill ${index}:`, container.getAttribute('data-category'));
            });
            
            // Set up initial filter state
            const activeButton = document.querySelector('.filter-btn.active');
            if (activeButton) {
                const initialCategory = activeButton.getAttribute('onclick').match(/filterSkills\('(.+)'\)/);
                if (initialCategory) {
                    console.log('Initial filter category:', initialCategory[1]);
                    filterSkills(initialCategory[1]);
                }
            }
        }

        function handleFilterClick(event) {
            event.preventDefault();
            
            // Update active button
            const filterButtons = document.querySelectorAll('.filter-btn');
            filterButtons.forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            // Get category from onclick attribute
            const onclickAttr = event.target.getAttribute('onclick');
            const categoryMatch = onclickAttr.match(/filterSkills\('(.+)'\)/);
            if (categoryMatch) {
                filterSkills(categoryMatch[1]);
            }
        }

        function filterSkills(category) {
            console.log('Filtering skills by category:', category);
            
            const skillContainers = document.querySelectorAll('[data-category]');
            console.log('Found skill containers:', skillContainers.length);
            
            let visibleCount = 0;
            
            skillContainers.forEach(container => {
                const containerCategory = container.getAttribute('data-category');
                console.log('Container category:', containerCategory, 'Filter category:', category);
                
                if (category === 'all') {
                    container.style.display = 'block';
                    container.classList.remove('d-none');
                    visibleCount++;
                } else {
                    if (containerCategory === category.toLowerCase()) {
                        container.style.display = 'block';
                        container.classList.remove('d-none');
                        visibleCount++;
                    } else {
                        container.style.display = 'none';
                        container.classList.add('d-none');
                    }
                }
            });
            
            console.log('Visible skills after filtering:', visibleCount);
            
            // Recalculate stats for visible cards
            setTimeout(() => {
                calculateVisibleSkillsStats();
            }, 100);
        }

        function calculateSkillsStats() {
            const skillCards = document.querySelectorAll('.skill-card');
            const totalSkills = skillCards.length;
            
            console.log('Calculating stats for', totalSkills, 'skills');
            
            if (totalSkills > 0) {
                let totalProficiency = 0;
                let expertCount = 0;
                const categories = new Set();
                
                skillCards.forEach(card => {
                    const progressBar = card.querySelector('.progress-bar');
                    if (progressBar) {
                        const proficiency = parseInt(progressBar.getAttribute('aria-valuenow') || '0');
                        totalProficiency += proficiency;
                        if (proficiency >= 80) expertCount++;
                    }
                    
                    const categoryBadge = card.querySelector('.badge');
                    if (categoryBadge) {
                        categories.add(categoryBadge.textContent.trim());
                    }
                });
                
                const avgProficiency = Math.round(totalProficiency / totalSkills);
                
                // Animate counters
                animateCounter('totalSkills', totalSkills);
                animateCounter('avgProficiency', avgProficiency, '%');
                animateCounter('categories', categories.size);
                animateCounter('expertSkills', expertCount);
            }
        }

        function calculateVisibleSkillsStats() {
            const visibleContainers = Array.from(document.querySelectorAll('[data-category]'))
                .filter(container => container.style.display !== 'none' && !container.classList.contains('d-none'));
            
            const totalVisible = visibleContainers.length;
            console.log('Calculating stats for', totalVisible, 'visible skills');
            
            if (totalVisible > 0) {
                let totalProficiency = 0;
                let expertCount = 0;
                const categories = new Set();
                
                visibleContainers.forEach(container => {
                    const progressBar = container.querySelector('.progress-bar');
                    const categoryBadge = container.querySelector('.badge');
                    
                    if (progressBar) {
                        const proficiency = parseInt(progressBar.getAttribute('aria-valuenow') || '0');
                        totalProficiency += proficiency;
                        if (proficiency >= 80) expertCount++;
                    }
                    
                    if (categoryBadge) {
                        categories.add(categoryBadge.textContent.trim());
                    }
                });
                
                const avgProficiency = Math.round(totalProficiency / totalVisible);
                
                // Update counters directly (no animation for filtering)
                document.getElementById('totalSkills').textContent = totalVisible;
                document.getElementById('avgProficiency').textContent = avgProficiency + '%';
                document.getElementById('expertSkills').textContent = expertCount;
                document.getElementById('categories').textContent = categories.size;
            }
        }

        function animateCounter(elementId, targetValue, suffix = '') {
            const element = document.getElementById(elementId);
            if (!element) return;
            
            const duration = 2000;
            const start = performance.now();
            
            function updateCounter(currentTime) {
                const elapsed = currentTime - start;
                const progress = Math.min(elapsed / duration, 1);
                const current = Math.floor(progress * targetValue);
                
                element.textContent = current + suffix;
                
                if (progress < 1) {
                    requestAnimationFrame(updateCounter);
                } else {
                    element.textContent = targetValue + suffix;
                }
            }
            
            requestAnimationFrame(updateCounter);
        }

        // Add visual effects for skill cards
        function addSkillCardEffects() {
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                        
                        // Animate progress bar
                        const progressBar = entry.target.querySelector('.progress-bar');
                        if (progressBar) {
                            const width = progressBar.getAttribute('aria-valuenow') + '%';
                            progressBar.style.width = '0%';
                            setTimeout(() => {
                                progressBar.style.width = width;
                            }, 200);
                        }
                    }
                });
            }, { threshold: 0.1 });

            // Observe skill cards
            const cards = document.querySelectorAll('.skill-card');
            cards.forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'all 0.6s ease';
                observer.observe(card);
            });
        }

        // Remove the old initializeFilters function since we have initializeSkillFilters now
    </script>
</asp:Content>