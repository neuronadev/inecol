import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mautorizado"
export default class extends Controller {
  connect() {
  }

  agregar(event){
      var py = event.params.idpy
      var target = document.getElementById("monto_autorizado")
      target.src = `/proyectos/${py}/mtoautorizados/new`
      target.reload()
  }

  editar(event){
    var url = event.params.url
    console.log(`${url}`) 
    var target = document.getElementById("monto_autorizado")
    target.src = url
    target.reload()
}

  cancelnew(event){
    var py = event.params.idpy
    var target = document.getElementById("monto_autorizado")
    target.src = `/proyectos/${py}/mtoautorizados/`
    target.reload()
  }


}
