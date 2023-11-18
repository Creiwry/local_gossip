
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  distanceThreshold(){
    return {
      distance: 20
    };
  } 

  initialize() {
    this.lastLatitude = null;
    this.lastLongitude = null;
    this.watchId = null;
  }

  startGeolocation(event) {
    this.route = event.currentTarget.dataset.route;
    if(this.watchId === null) {
      this.watchId = navigator.geolocation.watchPosition(this.success, this.error, this.options());
    }
  }

  stopGeolocation(event) {
    let watchId = event.currentTarget.dataset.watchId;
    let route = event.currentTarget.dataset.route;
    if(watchId !== null) {
      navigator.geolocation.clearWatch(watchId);

      fetch("/check_out", { 
        method: 'POST', 
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('[name=csrf-token]').content
        }, 
        body: JSON.stringify({ check_out: true, route: route })
      })
        .then(response => {
          if (response.redirected) {
            window.location.href = response.url;
          }
        })
        .catch(function(err) {
          console.info(err + " url: " + url);
        });
    }
  }

  success = (pos) => {
    const crd = pos.coords;
    if (this.shouldUpdateUser(crd)) {
      this.updateUser(crd, this.watchId, this.route);
    }
  }

  calculateDistance(lat1, lon1, lat2, lon2) {
    const RADIUSEARTH = 6371e3;
    const changeInLatitudeRad = (lat2 - lat1) * (Math.PI / 180);
    const changeInLongitudeRad = (lon2 - lon1) * (Math.PI / 180);

    const a = Math.sin(changeInLatitudeRad / 2) * Math.sin(changeInLatitudeRad / 2) +
      Math.cos(lat1 * (Math.PI / 180)) * Math.cos(lat2 * (Math.PI / 180)) *
        Math.sin(changeInLongitudeRad / 2) * Math.sin(changeInLongitudeRad / 2);

    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    let distance = RADIUSEARTH * c;

    return distance;
  }

  shouldUpdateUser(crd) {
    if (this.lastLatitude && this.lastLongitude) {
      const distance = this.calculateDistance(this.lastLatitude, this.lastLongitude, crd.latitude, crd.longitude);
      if (distance < DISTANCE_THRESHOLD) {
        return false;
      }
    }
    return true;
  }

  updateUser(crd, watchId, route) {
    this.lastLatitude = crd.latitude;
    this.lastLongitude = crd.longitude;
    fetch("/update_location", { 
      method: 'POST', 
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name=csrf-token]').content
      }, 
      body: JSON.stringify({ latitude: crd.latitude, longitude: crd.longitude, watchId: watchId, route: route })
    })
    .then(response => {
      if (response.redirected) {
        window.location.href = response.url;
      }
    })
    .catch(function(err) {
      console.info(err + " url: " + url);
    });
  }

  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  }

  options() {
    return {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0,
    };
  }
}
