/*
 * WebUIValidation.js - ASP.NET WebForms Client-side Validation
 * This file provides client-side validation functionality for WebForms controls
 */

// Global validation variables
var Page_Validators = [];
var Page_ValidationActive = false;

// Validation functions
function ValidatorOnLoad() {
    if (typeof Page_Validators !== 'undefined') {
        for (var i = 0; i < Page_Validators.length; i++) {
            ValidatorOnChange(Page_Validators[i]);
        }
    }
}

function ValidatorOnChange(validator) {
    if (validator && validator.style) {
        validator.style.display = 'none';
    }
}

function ValidatorValidate(validator) {
    if (!validator) return true;
    
    var isValid = true;
    var controlToValidate = validator.getAttribute('data-controltovalidate');
    
    if (controlToValidate) {
        var control = document.getElementById(controlToValidate);
        if (control) {
            var value = control.value || '';
            var validationType = validator.getAttribute('data-validation-type');
            
            switch (validationType) {
                case 'RequiredFieldValidator':
                    isValid = value.trim() !== '';
                    break;
                case 'RegularExpressionValidator':
                    var pattern = validator.getAttribute('data-validation-regex');
                    if (pattern && value) {
                        var regex = new RegExp(pattern);
                        isValid = regex.test(value);
                    }
                    break;
                case 'CompareValidator':
                    var compareValue = validator.getAttribute('data-compare-value');
                    if (compareValue) {
                        isValid = value === compareValue;
                    }
                    break;
                case 'RangeValidator':
                    var minValue = parseFloat(validator.getAttribute('data-min-value') || 0);
                    var maxValue = parseFloat(validator.getAttribute('data-max-value') || 0);
                    var numValue = parseFloat(value);
                    if (!isNaN(numValue)) {
                        isValid = numValue >= minValue && numValue <= maxValue;
                    }
                    break;
                default:
                    isValid = true;
                    break;
            }
        }
    }
    
    // Show/hide validator message
    if (validator.style) {
        validator.style.display = isValid ? 'none' : 'inline';
    }
    
    // Add/remove validation styling
    if (controlToValidate) {
        var control = document.getElementById(controlToValidate);
        if (control) {
            if (isValid) {
                control.classList.remove('is-invalid');
                control.classList.add('is-valid');
            } else {
                control.classList.remove('is-valid');
                control.classList.add('is-invalid');
            }
        }
    }
    
    return isValid;
}

function Page_ClientValidate(validationGroup) {
    var valid = true;
    
    if (typeof Page_Validators !== 'undefined') {
        for (var i = 0; i < Page_Validators.length; i++) {
            var validator = Page_Validators[i];
            var validatorGroup = validator.getAttribute('data-validation-group');
            
            if (!validationGroup || validatorGroup === validationGroup || !validatorGroup) {
                if (!ValidatorValidate(validator)) {
                    valid = false;
                }
            }
        }
    }
    
    return valid;
}

// Initialize validation when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
    // Find all validators on the page
    var validators = document.querySelectorAll('[data-validation-type]');
    Page_Validators = Array.from(validators);
    
    // Set up event handlers for validation
    Page_Validators.forEach(function(validator) {
        var controlToValidate = validator.getAttribute('data-controltovalidate');
        if (controlToValidate) {
            var control = document.getElementById(controlToValidate);
            if (control) {
                control.addEventListener('blur', function() {
                    ValidatorValidate(validator);
                });
                control.addEventListener('change', function() {
                    ValidatorValidate(validator);
                });
            }
        }
    });
    
    ValidatorOnLoad();
});