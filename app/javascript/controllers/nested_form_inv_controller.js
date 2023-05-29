import NestedForm from "stimulus-rails-nested-form";
import numeral from "numeral"

//import { PartUtil } from './participan_util.js'

export default class extends NestedForm {
  connect() {
    super.connect();
  }
  add(event){
      super.add(event);
  }  

  remove(event){
     //var partUtil = new PartUtil('', '')
     
     super.remove(event);

     this.mostrar_suma_porc()
  }
  //////
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