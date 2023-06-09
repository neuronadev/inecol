import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="caps"
export default class extends Controller {
  connect() {}
 
  repetidos(event){
       var value = event.target.value
       var wraper = event.target.closest('#wraper_caps')       
       var itemscapsol = wraper.getElementsByClassName('itemcapsol')
       var repetido = 0
       if ( itemscapsol.length > 1 ){
             for (let i = 0; i < itemscapsol.length; i++ ){
                     if (itemscapsol[i].value == value){
                            repetido ++;          
                     }
             }
             if ( repetido > 1 ){
                    event.target.value=''
                    alert("El capitulo ya fue seleccionado previamente, no se peuden repetir.")
             }
        }   
  } 

}
