import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="valcomm"
export default class extends Controller {
  connect() {}

  shwComm(event){
       let el = document.getElementById(event.params.ideval)
       if ( el.style.display === 'none' ){
              el.style.display = 'table-row'
       }else{
              el.style.display = 'none'
       }     
  }

  updateVista(){
       var fr_el = document.getElementById('py_content_sub')
       var btn = document.getElementById('btn_upvista')
       btn.innerHTML = "Actualizando Vista..."
       
       fr_el.reload()
  }

}
