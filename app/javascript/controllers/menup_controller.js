import { Controller } from "@hotwired/stimulus"

var token = document.querySelector('meta[name="csrf-token"]').content

const cssClick = ['menupactivo', 'bg-gradient-to-r', 'from-sky-600', 'to-cyan-400', 'text-white']
const cssClickRemove = ['rounded-full']

const cssUnselectedItem = ['menupactivo','group', 'flex', 'items-center', 'space-x-4', 'rounded-full', 'px-4', 'py-3', 'text-gray-600']


export default class extends Controller {
   connect() {
       
    }
   
    onOver(event){
     
    }

    onOut(event){

    }

    onClickItem(event){  
       this.clearActiveMenup()
       if (event.target.tagName == 'SPAN') {
               event.target.closest('.flex').classList.remove(...cssClickRemove)
               event.target.closest('.flex').classList.add(...cssClick)
       }
       if (event.target.tagName == 'A') {
                event.target.classList.remove(...cssClickRemove)
                event.target.classList.add(...cssClick)
       }
    }

    clearActiveMenup(){
          var items = document.getElementsByClassName('menupactivo')
          for (let i = 0; i < items.length; i++){
                   items[i].classList.remove(...cssClick)
          }
    }

}