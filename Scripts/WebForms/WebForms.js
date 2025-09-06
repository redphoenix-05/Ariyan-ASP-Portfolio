/*
 * WebForms.js - ASP.NET WebForms Client Script
 * This file provides basic WebForms functionality for client-side operations
 */

// WebForms namespace
if (typeof WebForm_AutoFocus === 'undefined') {
    function WebForm_AutoFocus(focusId) {
        var element = document.getElementById(focusId);
        if (element && element.focus) {
            element.focus();
        }
    }
}

if (typeof WebForm_DoPostBackWithOptions === 'undefined') {
    function WebForm_DoPostBackWithOptions(options) {
        var validationResult = true;
        if (options.validation) {
            if (typeof Page_ClientValidate === 'function') {
                validationResult = Page_ClientValidate(options.validationGroup);
            }
        }
        
        if (validationResult) {
            if (options.actionUrl) {
                document.forms[0].action = options.actionUrl;
            }
            __doPostBack(options.eventTarget, options.eventArgument);
        }
    }
}

if (typeof __doPostBack === 'undefined') {
    function __doPostBack(eventTarget, eventArgument) {
        var form = document.forms[0];
        if (form) {
            if (!form.__EVENTTARGET) {
                var hiddenField = document.createElement('input');
                hiddenField.type = 'hidden';
                hiddenField.name = '__EVENTTARGET';
                hiddenField.id = '__EVENTTARGET';
                form.appendChild(hiddenField);
            }
            if (!form.__EVENTARGUMENT) {
                var hiddenField = document.createElement('input');
                hiddenField.type = 'hidden';
                hiddenField.name = '__EVENTARGUMENT';
                hiddenField.id = '__EVENTARGUMENT';
                form.appendChild(hiddenField);
            }
            form.__EVENTTARGET.value = eventTarget;
            form.__EVENTARGUMENT.value = eventArgument;
            form.submit();
        }
    }
}

// Page validation function
if (typeof Page_ClientValidate === 'undefined') {
    function Page_ClientValidate(validationGroup) {
        var valid = true;
        var validators = document.querySelectorAll('span[data-validation-for]');
        
        validators.forEach(function(validator) {
            if (!validationGroup || validator.getAttribute('data-validation-group') === validationGroup) {
                var isValidatorValid = ValidatorValidate(validator);
                if (!isValidatorValid) {
                    valid = false;
                }
            }
        });
        
        return valid;
    }
}

// Basic validator function
if (typeof ValidatorValidate === 'undefined') {
    function ValidatorValidate(validator) {
        // Basic validation - in a real implementation, this would be more comprehensive
        return true;
    }
}