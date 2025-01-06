import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="seccperiodo"
export default class extends Controller {
  connect() {
  }


  mostrarsecc(event){
      let div_secc24 = document.getElementById('estructura')
      let div_secc25 = document.getElementById('estructura2025')
      if  ( event.params.seccion == 2024 ){
             if ( div_secc24.style.display == 'none' ){
                    div_secc24.style.display = 'flex'
             }else{
                    div_secc24.style.display = 'none'
             }      
      }
      if  ( event.params.seccion == 2025 ){
              if ( div_secc25.style.display == 'none' ){
                     div_secc25.style.display = 'flex'
              }else{
                     div_secc25.style.display = 'none'
              }      
      }
  }

}
