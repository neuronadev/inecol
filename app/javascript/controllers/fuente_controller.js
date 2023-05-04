import { Controller } from "@hotwired/stimulus"

var token = document.querySelector('meta[name="csrf-token"]').content

export default class extends Controller {
   connect() {}

   async onNacionalidad(event){
        var lugares = document.getElementById('fuente_lugar_id')
        lugares.options.length = 0
        var option_null = document.createElement('option')
        option_null.value = ''
        option_null.text = '-- Seleccione una opción --'
        lugares.add(option_null)
        try{
            var data = await fetch('/fuentes/lugar',{
                                     method: 'POST',
                                     headers: {'Content-Type':'application/json', 'Accept':'application/json', 'X-CSRF-Token': token },
                                     body: JSON.stringify( {idnac:event.target.value} )
                                  })
                                  .then(response=>response.json())
                                  .then( data=>{ 
                                                    for( var item of data ){
                                                             var option = document.createElement('option')
                                                             option.value = item.id
                                                             option.text = item.nomlugar
                                                             lugares.add(option)
                                                    }
                                               } )
        }catch(e){alert(e)} 
   }
}