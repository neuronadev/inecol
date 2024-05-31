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
                                  this.createLinkFile(blob, event.target.parentNode)
                                  //this.createHiddenBlobInput(blob);
                         }
              });
              
         })

     }

     directUploadWillStoreFileWithXHR(request) {
         console.log(request)
         request.upload.addEventListener("progress", event => { 
              console.log(event.loaded) 
              console.log(event.total) 
         })
     }

     createLinkFile(blob, el){
          var cont_item = el.parentNode
          var data = `<div class="flex border border-gray-400 border-b-2 border-t-0 border-l-0 border-r-0 w-full"> 
                        <div class="flex text-wrap w-9/12 text-wrap">  
                          <a href="/rails/active_storage/blobs/${blob.signed_id}/${blob.filename}" target="_blank" class="item_file text-blue-700"> 
                            ${blob.filename}    
                          </a>
                        </div> 
                        <div class="flex items-center justify-center w-3/12 text-red-700"><span data-action="click->archivo#quitarArch">Quitar</span></div>  
                      </div> 
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

     agreraCampos(event){
          var tipo = event.params.tipo
          var field_input = ''
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
                                                <input multiple="multiple" class="item_file" data-archivo-target="input" data-action="change->archivo#uploadFile" data-direct-upload-url="rails/active_storage/direct_uploads" type="file" name="proyecto[${field_input}][]" id="proyecto_${field_input}">
                                           </div>                        
                                           <div class="flex items-center justify-center w-3/12"><span data-action="click->archivo#quitarArch">Quitar</span></div>                            
                                        </div>
                                        `)
     }

     quitarArch(event){
          alert("Quitar archivo...")
     }

}
