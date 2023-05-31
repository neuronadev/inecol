import { Controller } from "@hotwired/stimulus"
import  WModal  from './modal.js'

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
        if (window.confirm("El proyecto será habilitado para revisión por parte de comite evaluador. ¿Desea continuar?")) {
             this.enviarpy(event.params.proyecto).then(result => { 
                     fr_el.src = '/proyectos/'
                     fr_el.reload()
              })
       }
    }
    mwcerrar(event) {
        wmodal.cerrar()
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