import { Controller } from "@hotwired/stimulus"

var token = document.querySelector('meta[name="csrf-token"]').content
let el = ''
let tmp_html = ''
let item_id = 0
let els = document.querySelectorAll("div.context")
let contextMenu = document.getElementById("context-menu");
// Connects to data-controller="organizar"
export default class extends Controller {
   
   

   connect() {
         
         els.forEach(function (el_item) {
               el_item.addEventListener("contextmenu", (e) => {
                  e.preventDefault();
                  let mouseX = e.clientX || e.touches[0].clientX;
                  let mouseY = e.clientY || e.touches[0].clientY;
                  let menuHeight = contextMenu.getBoundingClientRect().height;
                  let menuWidth = contextMenu.getBoundingClientRect().width;
                  let width = window.innerWidth;
                  let height = window.innerHeight;
                  if (width - mouseX <= 200) {
                    contextMenu.style.borderRadius = "5px 0 5px 5px";
                    contextMenu.style.left = width - menuWidth + "px";
                    contextMenu.style.top = mouseY + "px";
                    //right bottom
                    if (height - mouseY <= 200) {
                      contextMenu.style.top = mouseY - menuHeight + "px";
                      contextMenu.style.borderRadius = "5px 5px 0 5px";
                    }
                  }
                  //left
                  else {
                    contextMenu.style.borderRadius = "0 5px 5px 5px";
                    contextMenu.style.left = mouseX + "px";
                    contextMenu.style.top = mouseY + "px";
                    //left bottom
                    if (height - mouseY <= 200) {
                      contextMenu.style.top = mouseY - menuHeight + "px";
                      contextMenu.style.borderRadius = "5px 5px 5px 0";
                    }
                  }
                  item_id = el_item.dataset.iditem
                  let item_ctx = document.getElementById("context-menu")
                  item_ctx.innerHTML = `<div id="itemedit" class="item" data-action="click->organizar#ctxitem"><span>Editar nombre...</span></div>`
                  if ( el != '' ){
                       item_ctx.innerHTML = `<div id="itemedit" class="item"><span class="italic text-zinc-400">Editar nombre...</span></div>`
                   }
                  contextMenu.style.visibility = "visible";
              });
         });

         document.addEventListener("click", function (e) {
            if (!contextMenu.contains(e.target)) {
                 contextMenu.style.visibility = "hidden";
            }
         });
         document.addEventListener("keyup", function (e) {
             if (e.key === "Escape") { 
                  if ( el != '' ){
                      el.innerHTML = tmp_html
                      el = ''
                  }
             }
         });
   }
   
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
         let str_id = "item_" + item_id
         //item_id = event.params.iditem
         el = document.getElementById(str_id)
         tmp_html = el.innerHTML
         el.innerHTML = `
               <input id="txt${item_id}" type="text" name="nmItem" style="height:20px;width:auto;font-size:12px;" value="${tmp_html.trim()}" data-action="keyup->organizar#aplicar" >  
             `
   }

   async aplicar(event){

       let el_input = document.getElementById("txt"+item_id)
       if (event.key === "Escape") { 
             el.innerHTML = tmp_html
             el = ''
       }
       if (event.key === "Enter") {
             let cambio = await this.updatenombre(el_input.value)
             el.innerHTML = el_input.value
             el = ''
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

     
   ctxitem(event){
      contextMenu.style.visibility = "hidden"; 
      this.cambiarnm('')
   }


}
