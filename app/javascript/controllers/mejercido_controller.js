import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mejercido"
export default class extends Controller {
  connect() {
  }

  agregar(event){
     var py = event.params.idpy
     var target = document.getElementById("monto_ejercido")
     target.src = `/proyectos/${py}/mtoejercidos/new`
     target.reload()
 }
 
 cancelnew(event){
    var py = event.params.idpy
    var target = document.getElementById("monto_ejercido")
    target.src = `/proyectos/${py}/mtoejercidos`
    target.reload()
}

valmonto(event){
    
}


}
