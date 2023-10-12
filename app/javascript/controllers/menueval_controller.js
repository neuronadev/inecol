import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menueval"
export default class extends Controller {
  connect() { }
  

  clkOpcion(event){
    var item_nom = this.actOpcion(event.target)
    this.desacOpcion(item_nom)
  }

  actOpcion(item){
      var c = item.closest("#itemopt")
      c.classList.add("bg-gray-200")
      c.classList.remove("hover:bg-gray-200", "hover:ring-2")
    return c.dataset.nom 
  }

  desacOpcion(item_nom){
      var elements = document.getElementById("items_menu").getElementsByClassName("itemmenu")
      for (let i = 0; i < elements.length; i++) {
            if (elements[i].dataset.nom != item_nom ){
                  elements[i].classList.remove("bg-gray-200");  
                  elements[i].classList.add("hover:bg-gray-200", "hover:ring-2")
            }      
      }
  }
  

}
