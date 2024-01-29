import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidecontent"
export default class extends Controller {
  connect() {
  }

  addPeriodo(event){
      var cont = document.getElementById("periodo")
      var el = ``
      cont.insertAdjacentHTML("beforeend", el);
  } 
   

}
