import { Controller } from "@hotwired/stimulus"
import { Dropdown } from 'flowbite';
//import TinyPopupMenu from 'tiny-popup-menu';

var token = document.querySelector('meta[name="csrf-token"]').content
const items = [];
let dropdown = ''
let tmp_html = ''
let el = ''

/*
const tinyPopupMenu = new TinyPopupMenu({
     autoclose: true,
     margin: 5,
     offset: {
     x: 0,
     y: 0
     },
     className: '',
     arrow: true,
     stopClick: true,
     menuItems: [
     {
          content: 'Display alert',
          callback: () => alert('Alert')
     },
     {
          content: 'Display another alert',
          callback: () => alert('Another alert')
     },
     '-', // separator
     {
          content: 'Delete',
          callback: () => alert('Delete!'),
          className: 'delete'
     }
     ]
});*/

// Connects to data-controller="organizar"
export default class extends Controller {
      
   async connect() {

      /*   
         document.addEventListener("click", function (e) {
            if (!contextMenu.contains(e.target)) {
                 contextMenu.style.visibility = "hidden";
            }
         }); */
         document.addEventListener("keyup", function (e) {
             if (e.key === "Escape") { 
                  if ( el != '' ){
                      el.innerHTML = tmp_html
                      el = ''
                  }
                  //contextMenu.style.visibility = "hidden";
             }
         })
         
         
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
     let elms = document.getElementsByClassName(event.params.iditems)

     for ( let i = 0; i < elms.length; i++ ) {
          if ( elms[i].style.backgroundColor != 'orange' ){
                  elms[i].style.backgroundColor  = 'orange'
                  console.log(items.indexOf(elms[i].id))
                  if ( items.indexOf(elms[i].id) == -1 ){
                        items.push( elms[i].id )
                  }      
          }else{
                  elms[i].style.backgroundColor  = ''
                  let index = items.indexOf(elms[i].id)
                  if ( items.indexOf(elms[i].id) > -1 ){
                        items.splice(index, 1)
                  } 
          }
     }

   }

   async archivar(event){
       
        
        for ( let i = 0; i < items.length; i++ ) {
               let r = await this.moverItemPeriodo(items[i], event.params.periodo)
        }
        var fr_el = document.getElementById('pycontent')
        fr_el.src = '/proyectos/'
        fr_el.reload()

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
               <input id="txt${item_id}" 
                      type="text" name="nmItem" 
                      style="height:20px;width:300px;font-size:12px;" 
                      value="${tmp_html.trim()}" 
                      data-action="keyup->organizar#aplicar"
                      data-organizar-item-param=${item_id} >  
             `
   }

   async aplicar(event){
       let item_id = event.params.item
       let el_input = document.getElementById("txt" + item_id)
       //let str_id = "item_" + item_id
       //let el = document.getElementById(str_id)

       if (event.key === "Escape") { 
             el.innerHTML = tmp_html
             el = ''
       }
       if (event.key === "Enter") {
             let cambio = await this.updatenombre(el_input.value, item_id)
             el.innerHTML = el_input.value
             el = ''
       }
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
