/*
 * jQuery 3.6.0 Debug Version Placeholder
 * This file serves as a placeholder for jQuery debug version.
 * The actual jQuery library will be loaded from CDN via ScriptResourceMapping.
 */

// Basic jQuery placeholder to prevent undefined errors (debug version)
if (typeof jQuery === 'undefined') {
    window.jQuery = window.$ = function(selector) {
        console.log('jQuery Debug: Called with selector:', selector);
        console.warn('jQuery is loading from CDN. Please ensure internet connectivity.');
        return {
            ready: function(fn) { 
                console.log('jQuery Debug: Document ready called');
                if (document.readyState === 'loading') {
                    document.addEventListener('DOMContentLoaded', fn);
                } else {
                    fn();
                }
            },
            val: function(value) { 
                console.log('jQuery Debug: val() called with:', value);
                return value !== undefined ? this : ''; 
            },
            hide: function() { 
                console.log('jQuery Debug: hide() called');
                return this; 
            },
            show: function() { 
                console.log('jQuery Debug: show() called');
                return this; 
            },
            addClass: function(className) { 
                console.log('jQuery Debug: addClass() called with:', className);
                return this; 
            },
            removeClass: function(className) { 
                console.log('jQuery Debug: removeClass() called with:', className);
                return this; 
            },
            attr: function(name, value) { 
                console.log('jQuery Debug: attr() called with:', name, value);
                return this; 
            },
            prop: function(name, value) { 
                console.log('jQuery Debug: prop() called with:', name, value);
                return this; 
            },
            on: function(event, handler) { 
                console.log('jQuery Debug: on() called with event:', event);
                return this; 
            },
            off: function(event) { 
                console.log('jQuery Debug: off() called with event:', event);
                return this; 
            },
            click: function(handler) { 
                console.log('jQuery Debug: click() called');
                return this; 
            }
        };
    };
    
    // Mark as placeholder
    jQuery.isPlaceholder = true;
    jQuery.version = '3.6.0-placeholder-debug';
}