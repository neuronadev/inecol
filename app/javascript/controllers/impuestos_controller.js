import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="impuestos"
export default class extends Controller {

  static values = { url: String }

  connect() {
      
  }

  cambiar(event){
      var target = document.getElementById("porc_impuesto")
      target.src = event.params.url
      target.reload()
  }

  cancelar(event){
      var target = document.getElementById("porc_impuesto")
      target.src = event.params.url
      target.reload()
  }

  calcular(event){
      let costop = document.getElementById("costop").value
      let overhead = document.getElementById("overhead").value
      let estimulo = document.getElementById("estimulo").value
      let iva = document.getElementById("iva").value
      let totalgastos = document.getElementById("totalgastos").value
      let totalproyecto = document.getElementById("totalproyecto").value

      let params = {
          p_costop: costop,
          p_overhead: overhead,
          p_estimulo: estimulo,
          p_iva: iva,
          p_totalgastos: totalgastos,
          p_totalproyecto: totalproyecto
      }

      
  }

  overhead(){
         
  } 


}
