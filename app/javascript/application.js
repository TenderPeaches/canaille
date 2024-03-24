// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@rails/request.js"

// https://stackoverflow.com/questions/76743809/is-it-possible-to-just-update-rails-form-input-field-value-u(undesing-turbo-frames

// Update an input's value
Turbo.StreamActions.update_input = function() {
    
    const value = this.getAttribute("text");

    this.targetElements.forEach((target) => {
        target.value = value
    });

};

// Show and activate an input, which both presents the user with the opportunity to change the input's value and sends the value along with the form when it is submitted
Turbo.StreamActions.activate_inputs = function() {
    this.targetElements.forEach((target) => {
        target.disabled = false;            // enable the target
        target.classList.remove("hidden");  // show the target
    
    })
}

// Hide and deactivate an input, so that it is not shown to the user and its value is not submitted along with the form
Turbo.StreamActions.deactivate_inputs = function() {
    this.targetElements.forEach((target) => {
        target.disabled = true;            // enable the target
        target.classList.add("hidden");  // show the target
    })
}

// Hide a particular element
Turbo.StreamActions.hide = function() {
    const targets = this.targetElements.length > 0 ? this.targetElements : document.querySelector(this.target);

    if (targets != null) {
        targets.forEach((target) => {
            target.classList.add("hidden");
        })
    }
}

// Show a particular element
Turbo.StreamActions.show = function() {
    const targets = this.targetElements.length > 0 ? this.targetElements : document.querySelector(this.target);

    if (targets != null) {
        targets.forEach((target) => {
            target.classList.remove("hidden");
        })
    }
}