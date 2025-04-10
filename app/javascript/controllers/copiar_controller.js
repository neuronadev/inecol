import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copiar"
export default class extends Controller {
  connect() {
  }

  async txthtml(e){
      let td = document.getElementById("contxt")
      if (navigator.clipboard) {
        navigator.clipboard.writeText(text)
      } else {
        const input = document.createElement('textarea')
        input.value = td.childNodes[0].data
        document.body.appendChild(input)
        input.select()
        document.execCommand('copy')
        document.body.removeChild(input)
      }    

      // console.log(td.childNodes[0].data)

    }

 async pegartxt(e){
        
  
 }

}
