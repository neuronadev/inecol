import { Controller } from "@hotwired/stimulus"
import { Dropdown } from 'flowbite';
//import TinyPopupMenu from 'tiny-popup-menu';

var token = document.querySelector('meta[name="csrf-token"]').content
const items = [];
let dropdown = ''
let dropdown_btn = ''
let tmp_html = ''
let el = ''

// Connects to data-controller="organizar"
export default class extends Controller {
      
   async connect() {

      /*   
         document.addEventListener("click", function (e) {
            if (!contextMenu.contains(e.target)) {
                 contextMenu.style.visibility = "hidden";
            }
         }); */
         /*
         document.addEventListener("keyup", function (e) {
             if (e.key === "Escape") { 
                  if ( el != '' ){
                      el.innerHTML = tmp_html
                      el = ''
                  }
                  //contextMenu.style.visibility = "hidden";
             }
         })*/
         const targetElBtn = document.getElementById('dropdownSmall');
         const triggerElBtn = document.getElementById('dropdownSmallButton');
         const optionsBtn = {
               placement: 'bottom',
               triggerType: 'click',
               offsetSkidding: 0,
               offsetDistance: 10,
               delay: 300,
               ignoreClickOutsideClass: false,
               onHide: () => {},
               onShow: () => {},
               onToggle: () => {},
          };

          const instanceOptionsBtn = {
               id: 'dropdownDots',
               override: true
          };
         
         dropdown_btn = new Dropdown(targetElBtn, triggerElBtn, optionsBtn, instanceOptionsBtn);
        
   }


   openmenu(event){
     
      const targetEl = document.getElementById(`dropdownDots${event.params.item}`);
      const triggerEl = document.getElementById(`dropdownMenuIconButton${event.params.item}`);
      
      const options = {
          placement: 'bottom',
          triggerType: 'click',
          offsetSkidding: 0,
          offsetDistance: 10,
          delay: 300,
          ignoreClickOutsideClass: false,
          onHide: () => {},
          onShow: () => {},
          onToggle: () => {},
      };
      
      // instance options object
      const instanceOptions = {
        id: 'dropdownMenu',
        override: true
      };


      if (event.target.classList.contains("mactivo")) {
            event.target.classList.remove("mactivo");
       }else{
            event.target.classList.add("mactivo"); 
            dropdown = new Dropdown(targetEl, triggerEl, options, instanceOptions);
            dropdown.show();
       }

      

      
   }
   
   selFila(event){
      let celda = document.getElementById(`${event.target.id}`)
          
      if ( celda.checked ){
               celda.style.backgroundColor = 'orange'
               celda.closest("tr").style.backgroundColor = '#fff2f2'
               celda.closest("tr").style.fontStyle = 'italic'
      }else{
               celda.style.backgroundColor = 'unset'
               celda.closest("tr").style.backgroundColor = 'unset'
               celda.closest("tr").style.fontStyle = 'unset'
      }        

   }

   async archivar(event){
        dropdown_btn.toggle()
        let filas_ids = []
        
        let elems = document.getElementsByClassName("selitem")
        for await ( let el of elems ){
                console.log(el.checked)
                if ( el.checked ){
                        let parts = el.id.split("-")
                        filas_ids.push(parts[1])
                }
        }
        for ( let i=0; i < filas_ids.length; i++ ){
               document.getElementById(`celda-${filas_ids[i]}`).innerHTML = `<svg aria-hidden="true" class="w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
               <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/>
               <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentFill"/>
               </svg>`
        }
        for ( let i=0; i < filas_ids.length; i++ ){
                 let r = await this.moverItemPeriodo(filas_ids[i], event.params.periodo)
        }
        if ( event.params.periodo == 2024 ){
               var fr_orden = document.getElementById('lista_items_ord')
               fr_orden.src = fr_orden.src
               fr_orden.reload()
        }       
        if ( event.params.periodo == 2025 ){
               var fr_orden = document.getElementById('lista_items_ordper')
               fr_orden.src = fr_orden.src
               fr_orden.reload()
        }

        var fr_el = document.getElementById('pycontent')
        fr_el.src = '/proyectos/'
        fr_el.reload()


   }

   async moverItemPeriodo(py, periodo){
      let data
      try {
               data = await fetch('/proyectos/nombrecorto', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
                    body: JSON.stringify({ idproy:py, periodo: periodo})
               })
               .then(response => response.json())
               .then( json => { return json })
      }catch (e) { alert(e) }
      return data
   }
   
   /*handleDragStart(e) {
        
        e.target.style.opacity = '0.4';
        this.dragSrcEl = e.target;
        e.dataTransfer.effectAllowed = 'move';
        e.dataTransfer.setData('text/html', e.target.innerHTML);
     }*/

   async handleDrop(e) {
    e.stopPropagation(); // stops the browser from redirecting.
    if ( e.target !== 'estructura' ) {
         let p = await this.moverproy(this.dragSrcEl.id)
         if (p.nombre != '0'){
             
              /*e.target.insertAdjacentHTML('beforeend', `<div class="cursor-pointer font-semibold mb-2" data-action="click->organizar#abrirEnlace" data-enlace="${p.link}"> 
                                                            ${p.nombre}
                                                        </div>`
                                         ) *///e.dataTransfer.getData('text/html');
                                          
              var fr_el = document.getElementById('pycontent')
              fr_el.src = '/proyectos/'
              fr_el.reload()

              var fr_orden = document.getElementById('lista_items_ord')
              fr_orden.src = fr_orden.src
              fr_orden.reload()
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
         dropdown.hide()
         let item_id = event.params.item
         let str_id = "item_" + item_id
         el = document.getElementById(str_id)
         tmp_html = el.innerHTML
         el.innerHTML = `
           <div style="display:flex; flex-direction: column;"> 
                 <div>
                   <input id="txt${item_id}" 
                      type="text" name="nmItem" 
                      style="height:20px;width:300px;font-size:12px;" 
                      value="${tmp_html.trim()}">  
                 </div>
                 <div class="mt-1">     
                   <button type="button" data-action="click->organizar#cancelar" class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-1.5 px-1.5 rounded">
                      Cancelar
                   </button>
                   <button type="button" data-action="click->organizar#aplicar" data-organizar-item-param="${item_id}" 
                           class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1.5 px-1.5 rounded">
                       Aceptar
                   </button>
                 </div>     
             `
   }

   async aplicar(event){
       
       let item_id = event.params.item
       let el_input = document.getElementById("txt" + item_id)
       //let str_id = "item_" + item_id
       //let el = document.getElementById(str_id)
       let cambio = await this.updatenombre(el_input.value, item_id)
       el.innerHTML = el_input.value
       el = ''
       /*if (event.key === "Escape") { 
             el.innerHTML = tmp_html
             el = ''
       }
       if (event.key === "Enter") {
             let cambio = await this.updatenombre(el_input.value, item_id)
             el.innerHTML = el_input.value
             el = ''
       }*/
   }

   cancelar(event){
        el.innerHTML = tmp_html
        el = ''
   }

   async updatenombre(nm, item_id){
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

   async ctxmover(event){
       dropdown.hide()
       let item_py = event.params.item

       try {
          await fetch('/proyectos/moveritem', {
                  method: 'POST',
                  headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
                  body: JSON.stringify({ idproy:item_py})
          })
          .then(response => response.json())
          .then( json => { 
                    var fr_el = document.getElementById('pycontent')
                    fr_el.src = '/proyectos/'
                    fr_el.reload()
     
                    var fr_orden = document.getElementById('lista_items_ord')
                    fr_orden.src = fr_orden.src
                    fr_orden.reload()

                    var fr_orden_per = document.getElementById('lista_items_ordper')
                    fr_orden_per.src = fr_orden_per.src
                    fr_orden_per.reload()

                    
               })
       }catch (e) { alert(e) }

   }


}
