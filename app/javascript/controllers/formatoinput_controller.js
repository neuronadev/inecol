import { Controller } from "@hotwired/stimulus"
import Formato from 'controllers/formato'

let timer
// Connects to data-controller="formatoinput"
export default class extends Controller {
  connect() {
  }

  f_moneda(event){
    var formato = new Formato()
    event.target.value = formato.moneda(event.target.value)
  }

  unf_moneda(event){
    var formato = new Formato()
    event.target.value = formato.unformat(event.target.value)  
  }
  stopTyping(event){
      var formato = new Formato()
      clearTimeout(timer);
      const waitTime = 3000
      timer = setTimeout(() => {
           event.target.value = formato.moneda(event.target.value)
           console.log("Se ha concluido la escritura...")
      }, waitTime);
  }
  

}
