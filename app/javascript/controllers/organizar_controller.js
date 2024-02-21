import { Controller } from "@hotwired/stimulus"
var token = document.querySelector('meta[name="csrf-token"]').content
let el = ''
let tmp_html = ''
let item_id = 0
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

   cambiarnm(event){
         let str_id = "item_" + event.params.iditem
         item_id = event.params.iditem
         el = document.getElementById(str_id)
         tmp_html = el.innerHTML
         el.innerHTML = `
               <input id="txt${item_id}" type="text" name="nmItem" style="height:20px;width:auto;font-size:12px;" value="${tmp_html.trim()}" data-action="keyup->organizar#aplicar" >  
             `
         console.log(tmp_html)
   }

   async aplicar(event){

       let el_input = document.getElementById("txt"+item_id)
       if (event.key === "Escape") { 
             el.innerHTML = tmp_html
       }
       if (event.key === "Enter") {
             let cambio = await this.updatenombre(el_input.value)
             el.innerHTML = el_input.value
       }
   }

   async updatenombre(nm){
          let data
          try {
               data = await fetch('/proyectos/cambiarnm', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
                    body: JSON.stringify({ nombre:nm, item:item_id })
               })
               .then(response => response.json())
               .then( json => { return json })
          }catch (e) { alert(e) }
      return data
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
