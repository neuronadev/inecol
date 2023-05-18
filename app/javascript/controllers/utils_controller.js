import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="utils"
export default class extends Controller {

  connect() {
     
  }

  keyEnter(event){
      if (event.keyCode == 13){
            event.preventDefault()
      }
  }
  formatPorcent(event){
       event.target.value = event.target.value.replace(/[^0-9\.]/g,'');
  }

 
  
}
