import { Controller } from "@hotwired/stimulus"
import  PartUtil  from 'controllers/participan_util'
import numeral from "numeral"


var token = document.querySelector('meta[name="csrf-token"]').content
var partUtil = new PartUtil('', '')

// Connects to data-controller="participan"
export default class extends Controller {
  connect() {
    
  }

  sumaPorc(event) {
    if ( !partUtil.limiteMax() ){
           partUtil.mostrar_suma_porc()
    }else{
          event.target.value = ''
          partUtil.mostrar_suma_porc()
          alert('El total de porcentajes de validación no debe ser mayor a 100')
    }
  }

  onParticipante(event){
      
      if (event.target.value != ''){
          this.tipoPart(event.target.value).then(data=>{
                  let p = event.target.closest('.nested-form-wrapper')
                  let el = p.querySelector('.parttipo')
                  //el.innerHTML = data.nomtipo
          })
      }    
  }

  onResponsable(event){
    
    var chk_resp = document.getElementsByClassName('chkresp')
     for ( let i = 0; i < chk_resp.length; i++ ){
             chk_resp[i].checked = false
     }
     event.target.checked = true
    
  }

  async tipoPart(academicoid) {

    try {
      var data = await fetch('/participantes/tipopart', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-Token': token },
        body: JSON.stringify({ academico_id: academicoid })
      })
      .then(response => response.json())
      return data

    } catch (e) { alert(e) }
  }

}