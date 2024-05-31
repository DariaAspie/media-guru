// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import "chartkick/chart.js"
import '@popperjs/core'
import 'bootstrap'
import { Application } from "@hotwired/stimulus"

const application = Application.start()

//import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
