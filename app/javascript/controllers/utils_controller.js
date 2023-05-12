import { Controller } from "@hotwired/stimulus"
import numeral from "numeral"

// Connects to data-controller="utils"
export default class extends Controller {

  connect() {
    
  }

  keyEnter(event){
      if (event.keyCode == 13){
            event.preventDefault()
      }
  }
  formatPorcent(event){
       event.target.value = event.target.value.replace(/[^0-9\.]/g,'');
  }
  sumaPorc(){
       var tpinvest = document.getElementById('tpinvest')
       var tptec = document.getElementById('tptec')
       var tpf = document.getElementById('tpf')

       var poc_inves = document.getElementsByClassName('porinvest')
       var poc_tec = document.getElementsByClassName('portec')

       var sum_inves = 0.0
       var sum_tec = 0.0
       var total = 0.0

       Array.from(poc_inves, (el) => {
                 let v = numeral(el.value).value()/100
                 total += v
                 sum_inves += v
              })
       tpinvest.innerHTML = numeral(sum_inves).format('0%')

       Array.from(poc_tec, (el) => {
                let v = numeral(el.value).value()/100
                total += v
                sum_tec += v
             }) 
      tptec.innerHTML = numeral(sum_tec).format('0%')
      tpf.innerHTML = numeral(total).format('0%')
       
  }

}
