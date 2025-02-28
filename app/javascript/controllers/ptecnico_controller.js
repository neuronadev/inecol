import { Controller } from "@hotwired/stimulus"
import  PartUtil  from 'controllers/participan_util'

// Connects to data-controller="ptecnico"
export default class extends Controller {
  static targets = ['ttecnico', 'contecnico']
  connect() {
  }

  addItem(event){
    event.preventDefault()
    var tpl_c = this.ttecnicoTarget.innerHTML.replace(/NEW_TEC/g, Date.now())
    this.contecnicoTarget.insertAdjacentHTML('beforeend', tpl_c)
  }

  removeItem(event){
      var item = event.target.closest('.itemrw')
      var partUtil = new PartUtil('', '')

      item.querySelector("input[name*='_destroy']").value = 1
      item.style.display = "none"
      item.classList.remove('itemrw')
      
      partUtil.mostrar_suma_porc()
  }
}
