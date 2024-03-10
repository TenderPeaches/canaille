// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@rails/request.js"

// https://stackoverflow.com/questions/76743809/is-it-possible-to-just-update-rails-form-input-field-value-u(undesing-turbo-frames

Turbo.StreamActions.update_input = function() {
    
    const value = this.getAttribute("text");

    this.targetElements.forEach((target) => {
        target.value = value
    });

};