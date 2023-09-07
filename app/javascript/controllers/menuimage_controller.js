import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menuimage"
export default class extends Controller {
  connect() {}
  logo(){ 
     let logo_circular = document.getElementById("logo_circular") 
     let logo_expan = document.getElementById("logo_expan") 

     logo_circular.style.display = 'none'
     logo_expan.style.display = 'flex'

  }
  logoclear(){
    let logo_circular = document.getElementById("logo_circular")
    let logo_expan = document.getElementById("logo_expan")

    logo_circular.style.display = 'flex'
    logo_expan.style.display = 'none'
  }

}
