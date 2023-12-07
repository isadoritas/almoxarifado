import { Application } from "@hotwired/stimulus"
import 'bootstrap/dist/css/bootstrap'
import 'bootstrap/dist/js/bootstrap'
import "stylesheets/application"

//= require jquery/dist/jquery.js
//= require @popperjs/core/lib/popper.js
//= require bootstrap/dist/js/bootstrap.js
//= require main


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

