import { Controller } from "@hotwired/stimulus"
var token = document.querySelector('meta[name="csrf-token"]').content
// Connects to data-controller="organizar"
export default class extends Controller {
   
   connect() {}
    handleDragStart(e) {
    e.target.style.opacity = '0.4';
    this.dragSrcEl = e.target;
    e.dataTransfer.effectAllowed = 'move';
    e.dataTransfer.setData('text/html', e.target.innerHTML);
   }
   async handleDrop(e) {
    e.stopPropagation(); // stops the browser from redirecting.
    if ( e.target !== 'estructura' ) {
         let p = await this.moverproy(this.dragSrcEl.id)
         if (p.nombre != '0'){
              e.target.insertAdjacentHTML('beforeend', `<div class="cursor-pointer font-semibold mb-2" data-action="click->organizar#abrirEnlace" data-enlace="${p.link}"> ${p.nombre}</div>`) //e.dataTransfer.getData('text/html');
              var fr_el = document.getElementById('pycontent')
              fr_el.src = '/proyectos/'
              fr_el.reload()
         }else{
               alert("El proyecto aún no esta firmado")
         }      
    }
    return false;
   }

   abrirEnlace(e){
      
      var fr_el = document.getElementById('pycontent')
      fr_el.src = e.target.dataset.enlace
      fr_el.reload()
   }

   async moverproy(idproy){
        var data = await this.consultanombre(idproy)
        return data
   }
   async consultanombre(idproy){
        let data
        try {
              data = await fetch('/proyectos/nombrecorto', {
                      method: 'POST',
                      headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
                      body: JSON.stringify({ idproy:idproy})
              })
              .then(response => response.json())
              .then( json => { return json })
        }catch (e) { alert(e) }
     return data
   }

     
}
