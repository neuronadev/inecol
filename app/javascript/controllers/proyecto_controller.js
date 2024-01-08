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
   async onMedio(event){
      if ( event.target.value != '' ){
            var data = await this.tipoMedio(event.target.value)
            console.log(data.clave)
            if (data.clave == 'CONV') {
                  this.showMedio()
                  this.docConve(data.clave)
            } else {
                  this.hiddeMedio()
                  this.docConve(data.clave)
            }  
      }else{
            this.hiddeMedio()
      }     
   }
   docConve(tmedio){
         var secc_conv_files = document.getElementById('conv_files')
         if ( tmedio == 'CONV' ){
                secc_conv_files.style.display = 'none'
         }else{
                secc_conv_files.style.display = 'flex' 
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

   async onClasifica(event){
        /*this.activeMedios()
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
           })*/
           //this.activeMedios()
           var data_medio = await this.idxConvocatoria('CONV').then( r => { return r })
           let idx_medio = data_medio.medio_id
           var data_clasif = await this.tipoClasifica(event.target.value).then( c => { return c } )
           if (data_clasif.clave == 'CREC'){
                  let tpl_conv = `<div>
                                          <div class="flex cursor-pointer" data-action="click->proyecto#onOverheadTrue">
                                                <div id="iconTrue" class=" md:flex md:items-center w-6 border-2 border-solid rounded"> </div>
                                                <div class=" w-fit md:flex md:items-center ml-2 font-semibold">Proyecto con Overhead</div>
                                          </div>
                                  </div>
                                  <div class="ml-5">
                                         <div class="flex cursor-pointer" data-action="click->proyecto#onOverheadFalse">
                                             <div id="iconFalse" class=" md:flex md:items-center w-6 border-2 border-solid rounded"> </div>
                                             <div class=" w-fit md:flex md:items-center ml-2 font-semibold">Proyecto sin Overhead</div>
                                         </div>
                                   </div>`
                  document.getElementById("sel_overhead").innerHTML = tpl_conv            
           }
           if ( data_clasif.clave == 'PSERV' || data_clasif.clave == 'INCUR' ){
                  let tpl_conv = `<div>
                                                <div class="flex cursor-pointer" data-action="click->proyecto#onOverheadTrue">
                                                      <div id="iconTrue" class=" md:flex md:items-center w-6 border-2 border-solid rounded"> </div>
                                                      <div class=" w-fit md:flex md:items-center ml-2 font-semibold">Proyecto con Overhead</div>
                                                </div>
                                    </div>
                                    <div class="ml-5" style="display:none;">
                                          <div class="flex cursor-pointer" data-action="click->proyecto#onOverheadFalse">
                                                <div id="iconFalse" class=" md:flex md:items-center w-6 border-2 border-solid rounded"> </div>
                                                <div class=" w-fit md:flex md:items-center ml-2 font-semibold">Proyecto sin Overhead</div>
                                          </div>
                                    </div>`
                  document.getElementById("sel_overhead").innerHTML = tpl_conv                  
                  this.onOverheadTrue(event)
                  if ( data_clasif.clave == 'PSERV' ){
                        for ( let i = 0; i < options.length; i++ ) {
                              if (Number(options[i].value) == idx_medio ){
                                    options[i].disabled = true
                                    medios.options.selectedIndex = 0
                                    this.hiddeMedio()
                              }
                        }
                  }      
          }
          if (data_clasif.clave == 'SNREC'){
                  document.getElementById("sel_overhead").innerHTML = '<span class="italic font-semibold ">No aplica Overhead</span>'
                  document.getElementById("proyecto_overhead").value=0
          }
           
   }

   onOverheadTrue(event){
        document.getElementById("iconTrue").innerHTML = `<?xml version="1.0" encoding="iso-8859-1"?> <!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  --> <svg width="17" height="17" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" 	 viewBox="0 0 507.2 507.2" style="enable-background:new 0 0 507.2 507.2;" xml:space="preserve"> <circle style="fill:#32BA7C;" cx="253.6" cy="253.6" r="253.6"/> <path style="fill:#0AA06E;" d="M188.8,368l130.4,130.4c108-28.8,188-127.2,188-244.8c0-2.4,0-4.8,0-7.2L404.8,152L188.8,368z"/> <g> 	<path style="fill:#FFFFFF;" d="M260,310.4c11.2,11.2,11.2,30.4,0,41.6l-23.2,23.2c-11.2,11.2-30.4,11.2-41.6,0L93.6,272.8 		c-11.2-11.2-11.2-30.4,0-41.6l23.2-23.2c11.2-11.2,30.4-11.2,41.6,0L260,310.4z"/> 	<path style="fill:#FFFFFF;" d="M348.8,133.6c11.2-11.2,30.4-11.2,41.6,0l23.2,23.2c11.2,11.2,11.2,30.4,0,41.6l-176,175.2 		c-11.2,11.2-30.4,11.2-41.6,0l-23.2-23.2c-11.2-11.2-11.2-30.4,0-41.6L348.8,133.6z"/> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> </svg>`
        document.getElementById("iconFalse").innerHTML = ""
        document.getElementById("proyecto_overhead").value=1
   }
   onOverheadFalse(event){
      document.getElementById("iconFalse").innerHTML = `<?xml version="1.0" encoding="iso-8859-1"?> <!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  --> <svg width="17" height="17" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" 	 viewBox="0 0 507.2 507.2" style="enable-background:new 0 0 507.2 507.2;" xml:space="preserve"> <circle style="fill:#32BA7C;" cx="253.6" cy="253.6" r="253.6"/> <path style="fill:#0AA06E;" d="M188.8,368l130.4,130.4c108-28.8,188-127.2,188-244.8c0-2.4,0-4.8,0-7.2L404.8,152L188.8,368z"/> <g> 	<path style="fill:#FFFFFF;" d="M260,310.4c11.2,11.2,11.2,30.4,0,41.6l-23.2,23.2c-11.2,11.2-30.4,11.2-41.6,0L93.6,272.8 		c-11.2-11.2-11.2-30.4,0-41.6l23.2-23.2c11.2-11.2,30.4-11.2,41.6,0L260,310.4z"/> 	<path style="fill:#FFFFFF;" d="M348.8,133.6c11.2-11.2,30.4-11.2,41.6,0l23.2,23.2c11.2,11.2,11.2,30.4,0,41.6l-176,175.2 		c-11.2,11.2-30.4,11.2-41.6,0l-23.2-23.2c-11.2-11.2-11.2-30.4,0-41.6L348.8,133.6z"/> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> </svg>`
      document.getElementById("iconTrue").innerHTML = ""
      document.getElementById("proyecto_overhead").value=0
   }

   chkOvh(event){
         var clasifica = document.getElementById('proyecto_clasificacion_id').value
         if (clasifica != ''){
               var data = this.tipoClasifica(clasifica)
               data.then(val => {
                       if (val.ovh == 'S'){
                             event.target.checked = true
                             event.preventDefault()
                       }
                       if (val.ovh == 'N') {
                             event.target.checked = false
                             event.preventDefault()
                       }
               })
         }else{
               console.log(clasifica) 
         }
   }
   activeOVH(ovh){
       ovhEl.disabled = false 
       if ( ovh == 'S' ){
              ovhEl.checked = true 
              //ovhEl.disabled = true 
       }
       if (ovh == 'N') {
               ovhEl.checked = false
               //ovhEl.disabled = true
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