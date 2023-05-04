import { Controller } from "@hotwired/stimulus"

var token = document.querySelector('meta[name="csrf-token"]').content

export default class extends Controller {
   connect() { }

   onInterInst(event){
         var secc_institucion = document.getElementById('secc_institucion')
         if (event.target.checked){
                secc_institucion.style.display='flex'
         }else{
                secc_institucion.style.display='none'
                this.delInputsInterInst()
         }
   }

   delInputsInterInst(){
         var inputs = document.getElementsByClassName('txt-institu')
         Array.from(inputs, (el) => el.value = '' )
   } 
}