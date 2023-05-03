import { Controller } from "@hotwired/stimulus"

var token = document.querySelector('meta[name="csrf-token"]').content

export default class extends Controller {
    
  connect() {}

  async addItem(){
        var div_d = document.getElementById('list_inst')
        try{
              var data = await fetch('/proyectos/institucion',{
                                       method: 'GET',
                                       headers: {'Content-Type':'application/html'}
                                    })
                                    .then(response=>response.text())
                                    .then( data=>{ 
                                                  div_d.insertAdjacentHTML('beforeend',data)
                                                 } )
        }catch(e){alert(e)}
        
  }
}