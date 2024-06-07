import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "activestorage";
var token = document.querySelector('meta[name="csrf-token"]').content

export default class extends Controller {
     static targets = ["input", "progress"];

     connect() {}

     uploadFile(event) {
         
         Array.from(event.target.files).forEach((file) => {
              const upload = new DirectUpload(
                  file,
                  event.target.dataset.directUploadUrl,
                  this // callback directUploadWillStoreFileWithXHR(request)
              );

              upload.create((error, blob) => {
                         if (error){
                                  alert(error)
                         } else {
                                  this.createLinkFile(blob, event.target.parentNode, event.target)
                                  
                                  //this.createHiddenBlobInput(blob);
                         }
              });
         })

     }

     uploadEl(event){
          var tipo = event.params.tipo
          var idproyecto = event.params.idproyecto

          Array.from(event.target.files).forEach((file) => {
               const upload = new DirectUpload(
                   file,
                   event.target.dataset.directUploadUrl,
               );
 
               upload.create( async(error, blob) => {
                          if (error){
                                   alert(error)
                          } else {
                                   let d = await this.crearFile(blob.signed_id, tipo, idproyecto)
                                   this.createLinkEl(blob, event.target.parentNode, event.target, idproyecto)
                          }
               });
               
          })
 
      }

      async crearFile(idsigned, tipo, idproyecto){
            try {
                    var data = await fetch('/documentos/agregar', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
                    body: JSON.stringify({idsigned:idsigned, tipo:tipo, idproyecto:idproyecto})
            })
              .then(response => response.json())
                    return data
            }catch (e) { alert(e) }
      }

     directUploadWillStoreFileWithXHR(request) {
         //console.log(request)
         request.upload.addEventListener("progress", event => { 
              //console.log(event.loaded) 
              //console.log(event.total) 
         })
     }

     createLinkEl(blob, el, target, idproyecto){
          var cont_item = el.parentNode
          var data = `
                        <div class="flex text-wrap w-9/12 text-wrap">  
                          <input name="${target.name}" type="hidden" value="${blob.signed_id}" autocomplete="off" class="item_file">
                          <a href="/rails/active_storage/blobs/${blob.signed_id}/${blob.filename}" target="_blank" class="item_file text-blue-700"> 
                            ${blob.filename}    
                          </a>
                        </div> 
                        <div class="flex items-center justify-center w-3/12 text-red-700"><span data-archivo-idproyecto-param='${idproyecto}' data-archivo-sid-param='${blob.signed_id}' data-action="click->archivo#quitarArchEl">Quitar</span></div>  
                      
          `
          cont_item.innerHTML = data
     }

     createLinkFile(blob, el, target){
          var cont_item = el.parentNode
          var data = `
                        <div class="flex text-wrap w-9/12 text-wrap">  
                          <input name="${target.name}" type="hidden" value="${blob.signed_id}" autocomplete="off" class="item_file">
                          <a href="/rails/active_storage/blobs/${blob.signed_id}/${blob.filename}" target="_blank" class="item_file text-blue-700"> 
                            ${blob.filename}    
                          </a>
                        </div> 
                        <div class="flex items-center justify-center w-3/12 text-red-700"><span data-action="click->archivo#quitarArch" data-archivo-id-param = '0' data-archivo-action-param = 'NO'>Quitar</span></div>  
                      
          `
          cont_item.innerHTML = data
          /*  
          const elementLink = document.createElement('a')
          let textLink = document.createTextNode(blob.filename)
          let url = `/rails/active_storage/blobs/${blob.signed_id}/${blob.filename}`;

          elementLink.appendChild(textLink)
          elementLink.href = url
          elementLink.target = '_blank'
          elementLink.classList.add('item_file','p-1','text-blue-700')
          cont_item.appendChild(elementLink);
          */
 
     }

     agreraCamposEl(event){
          var tipo = event.params.tipo
          var field_input = ''
          var idproyecto = event.params.idproyecto
          if ( tipo == 'protocolo' ){
                  field_input = 'docprotocolos'
          }
          if ( tipo == 'convenio' ){
               field_input = 'docconvenios'
          }

          var wrap_items = document.getElementById(`cont_${tipo}`)
          wrap_items.insertAdjacentHTML('beforeend', 
                                        `
                                        <div class="item flex w-full">
                                           <div class="flex text-wrap w-9/12">  
                                                <input name="proyecto[${field_input}][]" type="hidden" value="" autocomplete="off">
                                                <input multiple="multiple" class="item_file" data-archivo-idproyecto-param="${idproyecto}" data-archivo-tipo-param="${tipo}" data-archivo-target="input" data-action="change->archivo#uploadEl" data-direct-upload-url="rails/active_storage/direct_uploads" type="file" name="proyecto[${field_input}][]" id="proyecto_${field_input}">
                                           </div>                        
                                           <div class="flex items-center justify-center w-3/12 text-red-700">
                                                   <span data-action="click->archivo#quitarArch" data-archivo-id-param = '0' data-archivo-action-param = 'NO' >Quitar</span>
                                           </div>
                                        </div>
                                        `)          
     }

     agreraCampos(event){
          var tipo = event.params.tipo
          var field_input = ''
          var controller = ''
          if ( tipo == 'protocolo' ){
                  field_input = 'docprotocolos'
                  controller = 'proyecto'
          }
          if ( tipo == 'convenio' ){
               field_input = 'docconvenios'
               controller = 'proyecto'
          }
          if ( tipo == 'evalidael' ){
               field_input = 'dcevaluaciones'
               controller = 'validacion'
          }
          if ( tipo == 'dictamen' ){
               field_input = 'docdictamenes'
               controller = 'dictamen'
          }
          if ( tipo == 'doccambio' ){
               field_input = 'doccambios'
               controller = 'enlace'
          }


          var wrap_items = document.getElementById(`cont_${tipo}`)
          wrap_items.insertAdjacentHTML('beforeend', 
                                        `
                                        <div class="item flex w-full">
                                           <div class="flex text-wrap w-9/12">  
                                                <input name="${controller}[${field_input}][]" type="hidden" value="" autocomplete="off">
                                                <input multiple="multiple" class="item_file" data-archivo-target="input" data-action="change->archivo#uploadFile" data-direct-upload-url="rails/active_storage/direct_uploads" type="file" name="${controller}[${field_input}][]" id="${controller}_${field_input}">
                                           </div>                        
                                           <div class="flex items-center justify-center w-3/12 text-red-700">
                                                   <span data-action="click->archivo#quitarArch" data-archivo-id-param = '0' data-archivo-action-param = 'NO' >Quitar</span>
                                           </div>
                                        </div>
                                        `)
     }

     async quitarArch(event){
          var action = event.params.action
          var id = event.params.id
 
          if ( action == 'edit' || action == 'update' || action == 'listel' ){
                 var data = await this.eliminardoc(id)
          }       

          var el_principal = event.target.parentNode.parentNode
          el_principal.remove()
     }

     async eliminardoc(id){
          try {
                var data = await fetch('/documentos/removatach', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
                body: JSON.stringify({ doc_id:id})
            })
                 .then(response => response.json())
                 return data
      
            } catch (e) { alert(e) }
     }

     async quitarArchEl(event){

          var el_principal = event.target.parentNode.parentNode
          var idsigned = event.params.sid
          var idproyecto = event.params.idproyecto

          try {
               var data = await fetch('/documentos/removatachel', {
               method: 'POST',
               headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
               body: JSON.stringify({idsigned:idsigned, idproyecto:idproyecto})
          })
            .then(response => response.json())
                    el_principal.remove()
          }catch (e) { alert(e) }

     }

}
