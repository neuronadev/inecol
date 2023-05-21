import { Controller } from "@hotwired/stimulus"

var token = document.querySelector('meta[name="csrf-token"]').content
var cssOver = ''
var cssOut = 'bg group flex items-center space-x-4 rounded-full px-4 py-3 text-gray-600'
var cssClick = 'relative flex items-center space-x-4 bg-gradient-to-r from-sky-600 to-cyan-400 px-4 py-3 text-white'

export default class extends Controller {
   connect() {
       console.log('Menup..')
    }
   
    onOver(event){
     
    }

    onOut(event){

    }

    onClickItem(event){  
         if (event.target.tagName == 'SPAN'){
               event.target.closest('.flex').classList.remove('bg-gradient-to-r')
         }
         if (event.target.tagName == 'A'){
            console.log( event.target.closest('.flex') )
       }
    }

}