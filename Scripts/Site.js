// Portfolio Website - Optimized JavaScript
// Performance-focused scripts with lazy loading and debouncing

(function() {
    'use strict';

    // Performance utilities
    const Utils = {
        // Debounce function for performance
        debounce: function(func, wait, immediate) {
            let timeout;
            return function executedFunction() {
                const context = this;
                const args = arguments;
                const later = function() {
                    timeout = null;
                    if (!immediate) func.apply(context, args);
                };
                const callNow = immediate && !timeout;
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
                if (callNow) func.apply(context, args);
            };
        },

        // Throttle function for scroll events
        throttle: function(func, limit) {
            let inThrottle;
            return function() {
                const args = arguments;
                const context = this;
                if (!inThrottle) {
                    func.apply(context, args);
                    inThrottle = true;
                    setTimeout(() => inThrottle = false, limit);
                }
            };
        },

        // Check if element is in viewport (for lazy loading)
        isInViewport: function(element) {
            const rect = element.getBoundingClientRect();
            return (
                rect.top >= 0 &&
                rect.left >= 0 &&
                rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
                rect.right <= (window.innerWidth || document.documentElement.clientWidth)
            );
        },

        // Lazy load images
        lazyLoadImages: function() {
            const images = document.querySelectorAll('img[data-src]');
            if ('IntersectionObserver' in window) {
                const imageObserver = new IntersectionObserver((entries, observer) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const img = entry.target;
                            img.src = img.dataset.src;
                            img.removeAttribute('data-src');
                            img.classList.remove('lazy');
                            observer.unobserve(img);
                        }
                    });
                });
                images.forEach(img => imageObserver.observe(img));
            }
        }
    };

    // Portfolio Animation Manager
    const AnimationManager = {
        // Counter animation with performance optimization
        animateCounters: function() {
            const counters = document.querySelectorAll('[data-count]');
            if ('IntersectionObserver' in window) {
                const counterObserver = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            this.startCounter(entry.target);
                            counterObserver.unobserve(entry.target);
                        }
                    });
                });
                counters.forEach(counter => counterObserver.observe(counter));
            } else {
                // Fallback for older browsers
                counters.forEach(counter => this.startCounter(counter));
            }
        },

        startCounter: function(element) {
            const target = parseInt(element.getAttribute('data-count'));
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
        },

        // Animate skill bars with intersection observer
        animateSkillBars: function() {
            const skillBars = document.querySelectorAll('.progress-bar, .skill-progress');
            if ('IntersectionObserver' in window) {
                const skillObserver = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const bar = entry.target;
                            const width = bar.style.width || bar.getAttribute('data-width');
                            if (width) {
                                bar.style.width = '0%';
                                setTimeout(() => {
                                    bar.style.width = width;
                                }, 100);
                            }
                            skillObserver.unobserve(bar);
                        }
                    });
                });
                skillBars.forEach(bar => skillObserver.observe(bar));
            }
        },

        // Fade in animations
        fadeInElements: function() {
            const elements = document.querySelectorAll('.fade-in, .slide-up');
            if ('IntersectionObserver' in window) {
                const fadeObserver = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.style.opacity = '1';
                            entry.target.style.transform = 'translateY(0)';
                            fadeObserver.unobserve(entry.target);
                        }
                    });
                });

                elements.forEach(element => {
                    element.style.opacity = '0';
                    element.style.transform = 'translateY(50px)';
                    element.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                    fadeObserver.observe(element);
                });
            }
        }
    };

    // Navigation Manager
    const NavigationManager = {
        init: function() {
            this.setActiveLink();
            this.handleNavbarScroll();
            this.setupSmoothScroll();
        },

        setActiveLink: function() {
            const currentPage = window.location.pathname.split('/').pop() || 'Default.aspx';
            const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
            
            navLinks.forEach(link => {
                const href = link.getAttribute('href');
                if (href === currentPage || (currentPage === '' && href === 'Default.aspx')) {
                    link.classList.add('active');
                } else {
                    link.classList.remove('active');
                }
            });
        },

        handleNavbarScroll: function() {
            const navbar = document.querySelector('.navbar');
            if (!navbar) return;

            const scrollHandler = Utils.throttle(() => {
                const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
                
                if (scrollTop > 100) {
                    navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                    navbar.style.backdropFilter = 'blur(20px)';
                } else {
                    navbar.style.background = '#FFFFFF';
                    navbar.style.backdropFilter = 'none';
                }
            }, 16); // ~60fps

            window.addEventListener('scroll', scrollHandler, { passive: true });
        },

        setupSmoothScroll: function() {
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
        }
    };

    // Performance Monitor
    const PerformanceMonitor = {
        init: function() {
            if ('performance' in window) {
                window.addEventListener('load', () => {
                    const loadTime = performance.now();
                    console.log(`?? Page loaded in ${Math.round(loadTime)} ms`);
                    
                    // Log navigation timing
                    const navigation = performance.getEntriesByType('navigation')[0];
                    if (navigation) {
                        console.log(`?? DOM loaded: ${Math.round(navigation.domContentLoadedEventEnd - navigation.domContentLoadedEventStart)} ms`);
                        console.log(`?? Load complete: ${Math.round(navigation.loadEventEnd - navigation.loadEventStart)} ms`);
                    }
                });
            }
        }
    };

    // Main initialization
    function initPortfolio() {
        // Initialize all managers
        NavigationManager.init();
        AnimationManager.animateCounters();
        AnimationManager.animateSkillBars();
        AnimationManager.fadeInElements();
        Utils.lazyLoadImages();
        PerformanceMonitor.init();

        console.log('? Portfolio initialized successfully');
    }

    // Wait for DOM to be ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initPortfolio);
    } else {
        initPortfolio();
    }

    // Export for global access if needed
    window.PortfolioApp = {
        Utils,
        AnimationManager,
        NavigationManager,
        PerformanceMonitor
    };

})();