// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
// import 'bootstrap'
import GeolocationController from "./controllers/geolocation_controller"
import { application } from "./controllers/application"
application.register("geolocation", GeolocationController)
