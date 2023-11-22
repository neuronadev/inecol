import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="valcomm"
export default class extends Controller {
  connect() {}

  shwComm(event){
       let el = document.getElementById(event.params.ideval)
       if ( el.style.display === 'none' ){
              el.style.display = 'table-row'
       }else{
              el.style.display = 'none'
       }     
  }

}
