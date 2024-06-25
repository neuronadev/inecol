import { Controller } from "@hotwired/stimulus"
import SlimSelect from 'slim-select'

let tags = []

let ulField = ''
// Connects to data-controller="inputmail"
export default class extends Controller {
    
  connect() {
     ulField = document.getElementById('suggestions');

  }

  autoComplete(inputValue) {
    let data = []
    data.push('emma.gomez@inecol.mx')
    data.push('gerardo.mata@inecol.mx')
    data.push('gloria.martinez@inecol.mx')
    return data.filter(
         (value) => value.toLowerCase().includes(inputValue.toLowerCase())
    );
  }

  addItem(value) {
       ulField.innerHTML = ulField.innerHTML + `<li data-action='click->inputmail#selectItem'>${value}</li>`;
  }

  selectItem(event) {
     let inputField = document.getElementById('inemail');

     tags.push(event.target.textContent)
     this.crearTag()
     ulField.innerHTML = ``;
     inputField.value = ''
     inputField.focus()
  }

  addtag(event){
     let value = event.target.value

      if (event.key === 'Enter'){
           if( value.trim().length > 0 ){
                    if ( this.validaemail(event.target.value) ){
                              tags.push(event.target.value)
                              this.crearTag()
                              event.target.value = ''
                    }else{
                         //alert('No es un correo valido') 
                    }
           }    
      }else{
            if (value && value.trim().length > 1){
                  value = value.trim().toLowerCase()
                  ulField.innerHTML = ``;
                  let autoCompleteValues = this.autoComplete(value);
                  autoCompleteValues.forEach(value => { this.addItem(value); })
             }
      }
      
  }

  crearTag(){
       let tagContainer = document.getElementById("conttags")
       this.reset() 
       tags.slice().reverse().forEach(tag=>{
            let input = this.crearEl(tag)
            tagContainer.prepend(input)
       })

  }

  crearEl(label){
     
     const div = document.createElement("div")
     div.setAttribute('class', 'flex h-11 tag items-center max-w-xs p-4 text-blue-500 bg-white rounded-lg shadow dark:text-gray-blue dark:bg-blue-800 ml-1')
     div.setAttribute('role', 'alert')
        
     const span = document.createElement("span")
     span.innerHTML = label
     span.setAttribute('class', 'self-center')

     const closeBtn = document.createElement('button')
     closeBtn.setAttribute('type','button')
     closeBtn.setAttribute('class', 'self-center ms-auto -mx-1.5 -my-1.5 bg-gray-100 text-sm text-gray-600 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1 hover:bg-gray-100 inline-flex items-center justify-center h-8 w-8 dark:text-gray-500 dark:hover:text-white dark:bg-gray-800 dark:hover:bg-gray-700 ml-1')
     closeBtn.setAttribute('data-item', label)
     closeBtn.setAttribute('data-action','click->inputmail#delete')
     closeBtn.innerHTML = 'X'

     div.appendChild(span)
     div.appendChild(closeBtn)

     return div
  }  

  delete(event){
       let value = event.target.dataset.item
       let index = tags.indexOf(value)
       tags = [...tags.slice(0, index), ...tags.slice(index + 1) ]
       this.crearTag()
  }

  reset(){
       document.querySelectorAll('.tag').forEach(tag=>{
              tag.parentElement.removeChild(tag)
       })
  }

  validaemail(txt){
     let exp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/
     return exp.test(txt)
  }

  prevent(event){
     if (event.keyCode == 13){
          event.preventDefault()
    }
  }

  undecora(event){
      //event.target.style.border = '1px solid #000';
  }

}
