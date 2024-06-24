import { Controller } from "@hotwired/stimulus"
import SlimSelect from 'slim-select'

let tags = []


// Connects to data-controller="inputmail"
export default class extends Controller {
    
  connect() {
     
  }

  addtag(event){
      if (event.key === 'Enter'){
            tags.push(event.target.value)
            this.crearTag()
      }
      
  }

  crearTag(){

       let tagContainer = document.getElementById("conttags")
       let input = this.crearEl("okoko")
       tagContainer.prepend(input)
       /*tags.slice().reverse().forEach( function(tag){
            console.log("okok")
            let input = this.crearEl(tag)
            tagContainer.prepend(input)
            
       })*/
  }

  crearEl(label){
     
     const div = document.createElement("div")
     div.setAttribute('class', 'flex h-11 tag')
          
     const span = document.createElement("span")
     span.innerHTML = label
     span.setAttribute('class', 'self-center')

     const closeBtn = document.createElement('i')
     closeBtn.setAttribute('class', 'self-center')
     closeBtn.setAttribute('data-item', label)
     closeBtn.innerHTML = 'X'

     div.appendChild(span)
     div.appendChild(closeBtn)

     return div
  }  


  prevent(event){
     if (event.keyCode == 13){
          event.preventDefault()
    }
  }

  undecora(event){
      console.log("focus")
      //event.target.style.border = '1px solid #000';
  }

}
