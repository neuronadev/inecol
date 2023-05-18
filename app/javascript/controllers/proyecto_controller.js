import { Controller } from "@hotwired/stimulus"

var token = document.querySelector('meta[name="csrf-token"]').content
var medios = ''
var options = ''
var ovhEl = ''
export default class extends Controller {
   connect() {

         medios = document.getElementById('proyecto_medio_id')
         options = medios.getElementsByTagName('option')
         ovhEl = document.getElementById('proyecto_overhead')
    }

   onInterInst(event){
         var secc_institucion = document.getElementById('secc_institucion')
         if (event.target.checked){
                secc_institucion.style.display='flex'
         }else{
                secc_institucion.style.display='none'
                this.delInputsInterInst()
         }
   }
   onMedio(event){
   
      if ( event.target.value != '' ){
            var data = this.tipoMedio(event.target.value)
            data.then(val => {
                  if ( val.clave == 'CONV' ){
                       this.showMedio()
                  } else{
                       this.hiddeMedio() 
                  }  
            })
      }else{
            this.hiddeMedio()
      }     
   }
   hiddeMedio(){
      var secc_convoca = document.getElementById('secc_convoca') 
      secc_convoca.style.display='none'  
   }
   showMedio(){
      var secc_convoca = document.getElementById('secc_convoca') 
      secc_convoca.style.display='flex'
      
   }

   async tipoMedio(medioid){
      try {
            var data = await fetch('/proyectos/tipomedio', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
                body: JSON.stringify({ medio_id:medioid})
            })
             .then(response => response.json())
             return data
                
        } catch (e) { alert(e) }
   }

   onClasifica(event){
        this.activeMedios()
        var data_medio = this.idxConvocatoria('CONV')
        data_medio.then(val=>{ 
                 let idx_medio = val.medio_id 
                 var data = this.tipoClasifica(event.target.value)
                 data.then(val=>{
                         if (val.clave == 'PSERV'){
                              for ( let i = 0; i < options.length; i++ ) {
                                      if (Number(options[i].value) == idx_medio ){
                                             options[i].disabled = true
                                             medios.options.selectedIndex = 0
                                             this.hiddeMedio()
                                      }
                                }
                         }
                         this.activeOVH(val.ovh)

                 })
           })
        
        
   }

   activeOVH(ovh){
       ovhEl.disabled = false 
       if ( ovh == 'S' ){
              ovhEl.checked = true 
              ovhEl.disabled = true 
       }
       if (ovh == 'N') {
               ovhEl.checked = false
               ovhEl.disabled = true
       }
   } 

   activeMedios(){
      for ( let i = 0; i < options.length; i++ ) {
              options[i].disabled = false
      }
      medios.options.selectedIndex = 0
      this.hiddeMedio()
   }

   async tipoClasifica(clasificaid){
      try {
            var data = await fetch('/proyectos/tipoclasifica', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
                body: JSON.stringify({ clasifica_id:clasificaid})
            })
             .then(response => response.json())
             return data
                
        } catch (e) { alert(e) }
   }

   
   async idxConvocatoria(clave){
      try {
            var data = await fetch('/proyectos/medclave', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
                body: JSON.stringify({ clave_medio:clave})
            })
             .then(response => response.json())
             return data
                
        } catch (e) { alert(e) }
   }



   delInputsInterInst(){
         var inputs = document.getElementsByClassName('txt-institu')
         Array.from(inputs, (el) => el.value = '' )
   } 
}