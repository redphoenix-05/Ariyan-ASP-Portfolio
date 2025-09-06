/*
 * GridView.js - ASP.NET WebForms GridView Control Support
 * Basic implementation for GridView functionality
 */

var GridViewNamespace = {
    initialize: function() {
        console.log('GridView controls initialized');
    },
    
    selectRow: function(element) {
        if (element) {
            var rows = element.parentNode.children;
            for (var i = 0; i < rows.length; i++) {
                rows[i].classList.remove('selected');
            }
            element.classList.add('selected');
        }
    }
};

document.addEventListener('DOMContentLoaded', function() {
    GridViewNamespace.initialize();
});