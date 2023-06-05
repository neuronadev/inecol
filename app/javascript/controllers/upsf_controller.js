import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "activestorage";
var token = document.querySelector('meta[name="csrf-token"]').content
// Connects to data-controller="upsf"
export default class extends Controller {
  static targets = ["input", "progress"];
  connect() {}

 delFile(event){
       let items = event.target.closest('#div_file').querySelectorAll(".item_file")
       console.log(items)
       for ( let i = 0; i < items.length; i++ ){
              if ( i == 0 ){
                    items[i].style.display = 'flex'
                    items[i].value = ''
              }else{
                    items[i].remove()
              }
       }
  }
  delFileEdit(event){
      let items = event.target.closest('#div_file').querySelectorAll(".item_file")
      for ( let i = 0; i < items.length; i++ ){
           if ( i == 0 ){
                 items[i].style.display = 'flex'
                 items[i].value = ''
           }else{
                 items[i].remove()
           }
      }
      this.deldoc(event.params.idpy).then(result=>{ alert('Archivo Eliminado') })
  }

  async deldoc(id){
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

  uploadFile(event) {
    Array.from(this.inputTarget.files).forEach((file) => {
          console.log(file) 
          const upload = new DirectUpload(
                                            file,
                                            this.inputTarget.dataset.directUploadUrl,
                                            this // callback directUploadWillStoreFileWithXHR(request)
                                         );
          upload.create((error, blob) => {
                          if (error){
                                     console.log(error);
                          } else {
                                     this.createLinkFile(blob)
                                     this.createHiddenBlobInput(blob);
                                     
                                     // if you're not submitting the form after upload, you need to attach
                                     // uploaded blob to some model here and skip hidden input.
                          }
          });
      
    });
    event.target.style.display = 'none'
    event.target.value = ''
  }



  createLinkFile(blob) {
    const elementLink = document.createElement('a')
    let textLink = document.createTextNode(blob.filename)
    let url = `/rails/active_storage/blobs/${blob.signed_id}/${blob.filename}`;

    elementLink.appendChild(textLink)
    elementLink.href = url
    elementLink.target = '_blank'
    elementLink.classList.add('item_file','text-blue-700')
    this.element.appendChild(elementLink);

    let btn = document.createElement("button");

    btn.innerHTML = " Eliminar";
    btn.type = "button";
    btn.classList.add('item_file','p-2','text-red-700')

    btn.dataset.action ='upsf#delFile'
    this.element.appendChild(btn);


  }


  // add blob id to be submitted with the form
  createHiddenBlobInput(blob) {
    const hiddenField = document.createElement("input");
    hiddenField.classList.add('item_file')
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("value", blob.signed_id);
    hiddenField.name = this.inputTarget.name;
    this.element.appendChild(hiddenField);
  }

  directUploadWillStoreFileWithXHR(request) {
    request.upload.addEventListener("progress", (event) => {
            this.progressUpdate(event);
    });
  }

  progressUpdate(event) {
    const progress = (event.loaded / event.total) * 100;
    //this.progressTarget.innerHTML = progress;

    // if you navigate away from the form, progress can still be displayed 
    // with something like this:
    // document.querySelector("#global-progress").innerHTML = progress;
  }

}
