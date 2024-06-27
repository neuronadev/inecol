import { Controller } from "@hotwired/stimulus"
import {TabulatorFull as Tabulator} from 'tabulator-tables';

var token = document.querySelector('meta[name="csrf-token"]').content
var table 

// Connects to data-controller="tabla"
export default class extends Controller {

 async connect() {
       var items = []
       await this.proyinf().then(datos => {
            datos.forEach(item => {
                    items.push(item)
            })
            table = new Tabulator("#table-pfin", {
                        height:'605px',
                        data:items,
                        dataTree:true,
                        dataTreeChildIndent:15,
                        renderHorizontal:"virtual",
                        columns:[ 
                            {formatter:"rownum", hozAlign:"center", width:40, frozen:true}, 
                            {title:"Nombre del proyecto", field:"nombre", width:500, responsive:0, frozen:true},
                            {title:"Fuente de financiamiento", field:"fuente", width:450},
                            {title:"Tipo de Proyecto", field:"tipoproy", width:180},
                            {title:"Fecha de inicio", field:"finicio", width:100, hozAlign:"center", accessorDownload: this.valorNull},
                            {title:"Fecha de termino", field:"ftermino", width:100, hozAlign:"center", accessorDownload: this.valorNull}, 
                            {title:"Porcentaje de avance", field:"porcentaje", width:80, hozAlign:"center", accessorDownload: this.valorNull},
                            {title:"Monto autorizado", field:"montoaut", hozAlign:"right", width:90}, 
                            {title:"Monto ejercido", field:"montoejer", hozAlign:"right", width:90},
                            {title:"Responsable", field:"resp", width:100},
                            {title:"Comentarios", field:"comen", width:100},
                        ]
            })
       })
      
       
 }

  valorNull(value, data, type, component){
          if (value == null){
               return ''
          }else{
              return value
          }
  }
  
  async proyinf(){
        try {
            var data = await fetch('/reportes/pinvfin', {
                method: 'GET',
                headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token }
            })
             .then(response => response.json())
            return data 
         } catch (e) { alert(e) }
  }


  download(event){
      console.log("qqq")
      table.download("xlsx", "informacion.xlsx", {sheetName:"Datos"});
  }

}
