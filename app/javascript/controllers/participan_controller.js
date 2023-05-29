import { Controller } from "@hotwired/stimulus"
//import { PartUtil } from './participan_util.js'
import numeral from "numeral"


var token = document.querySelector('meta[name="csrf-token"]').content
//var partUtil = new PartUtil('', '')

// Connects to data-controller="participan"
export default class extends Controller {
  connect() {
    
  }

  sumaPorc(event) {
    if ( !this.limiteMax() ){
           this.mostrar_suma_porc()
    }else{
          event.target.value = ''
          this.mostrar_suma_porc()
          alert('El total de porcentajes de validación no debe ser mayor a 100')
    }
  }

  onParticipante(event){
      this.tipoPart(event.target.value).then(data=>{
              let p = event.target.closest('.nested-form-wrapper')
              let el = p.querySelector('.parttipo')
              el.innerHTML = data.nomtipo
      })
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

  ////////////////
  limiteMax() {
    var limite_porc_part = 1
    if ((this.suma_invest() + this.suma_tec()) > limite_porc_part) {
      return true
    } else {
      return false
    }
  }

  mostrar_suma_porc() {

    var tpinvest = document.getElementById('tpinvest')
    var tptec = document.getElementById('tptec')
    var tpf = document.getElementById('tpf')
    var total = 0.0

    tpinvest.innerHTML = numeral(this.suma_invest()).format('0%')
    tptec.innerHTML = numeral(this.suma_tec()).format('0%')
    tpf.innerHTML = numeral(this.suma_invest() + this.suma_tec()).format('0%')
  }

  suma_invest() {
    var sum_inves = 0.0
    var poc_inves = document.getElementsByClassName('porinvest')
    Array.from(poc_inves, (el) => {
      let v = numeral(el.value).value() / 100
      sum_inves += v
    })
    return sum_inves
  }

  suma_tec() {
    var sum_tec = 0.0
    var poc_tec = document.getElementsByClassName('portec')
    Array.from(poc_tec, (el) => {
      let v = numeral(el.value).value() / 100
      sum_tec += v
    })
    return sum_tec
  }

}