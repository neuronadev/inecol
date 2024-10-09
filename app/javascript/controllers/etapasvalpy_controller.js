import { Controller } from "@hotwired/stimulus"
import  WModal  from 'controllers/modal'

var m = ''
var wmodal = ''
var token = document.querySelector('meta[name="csrf-token"]').content
export default class extends Controller {
    connect() {
        m = document.getElementById('modalEl')
        wmodal = new WModal(m)
     }

    mensaje(event){
        //wmodal.mostrar()
            var fr_el = document.getElementById('pycontent')
        if (window.confirm("El proyecto será habilitado para revisión por parte del área de Proyectos Externos. ¿Desea continuar?")) {
             let button = document.getElementById("btn_enviar");
             button.disabled = true; 
             let txt_btn = document.getElementById("txt_btn_enviar");
             txt_btn.innerHTML = "Un momento..."
             this.enviarpy(event.params.proyecto).then(result => { 
                     fr_el.src = '/proyectos/'
                     fr_el.reload()
              })
       }
    }

    async seguimiento(event){

        if ( event.target.checked ){
               if (window.confirm("El proyecto será habilitado para seguimiento por parte del investigador(a) responsable. ¿Desea continuar?")) {
                       let r = await this.activarseg(event.params.idpy, true)
                       if(r.seguimiento){
                               alert("Proyecto activado correctamente.")
                       }
               }else{  event.target.checked = false }
        }else{
            if (window.confirm("El seguimiento del proyecto será deshabilitado. ¿Desea continuar?")) {
                       let r = await this.activarseg(event.params.idpy, false)
                       if(!r.seguimiento){
                                alert("Proyecto desactivad correctamente.")
                       }
            }else{ event.target.checked = true }
        } 
    }

    async activarseg(idpy, tipo){
        try {
            var data = await fetch('/proyectos/seguimiento', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-Token': token },
                body: JSON.stringify({ id: idpy, tipo: tipo })
            })
            .then(response => response.json())
          return data
       } catch (e) { alert(e) }
    }

    mwcerrar(event) {
        wmodal.cerrar()
    }

    msgeliminar(event){
        var fr_el = document.getElementById('pycontent')
        if (window.confirm("¿Desea eliminar esta información?")) {
            this.eliminarpy(event.params.proyecto).then(result => {
                fr_el.src = '/proyectos/'
                fr_el.reload()
            })
        }
    }

    async eliminarpy(proyecto){
            try {
                var data = await fetch('/proyectos/eliminar', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-Token': token },
                    body: JSON.stringify({ id: proyecto })
                })
               .then(response => response.json())
                return data

            } catch (e) { alert(e) }
    }
    
    async enviarpy(proyecto){
        try {
            var data = await fetch('/proyectos/enviar', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-Token': token },
                body: JSON.stringify({ id: proyecto })
            })
                .then(response => response.json())
            return data

        } catch (e) { alert(e) }
    }


}