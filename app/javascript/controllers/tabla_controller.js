import { Controller } from "@hotwired/stimulus"
import {TabulatorFull as Tabulator} from 'tabulator-tables';

var token = document.querySelector('meta[name="csrf-token"]').content
var items = []
var table 
// Connects to data-controller="tabla"
export default class extends Controller {
 async connect() {
               
        //create Tabulator on DOM element with id "example-table"        
        await this.proyinf().then(d=>{
             items = d
                table = new Tabulator("#table-pfin", {
                height:'605px', 
                dataTreeStartExpanded:true,
                dataTreeElementColumn:"nombre",
                dataTreeChildField:"outlineChildren",
                dataTreeBranchElement:false,
                dataTreeChildIndent:17,
                scrollToRowPosition: "center",
                data:d, 
                
                columns:[ //Define Table Columns
                    {title:"Nombre del proyecto", field:"nombre", width:280 },
                    {title:"Fuente de financiamiento", field:"fuente", width:180},
                    {title:"Tipo de Proyecto", field:"tipoproy", width:180},
                    {title:"Fecha de inicio", field:"finicio", width:100, accessorDownload: this.valorNull},
                    {title:"Fecha de termino", field:"ftermino", width:100, accessorDownload: this.valorNull}, 
                    {title:"Porcentaje de avance", field:"porcentaje", width:80, accessorDownload: this.valorNull},
                    {title:"Monto autorizado", field:"montoaut", width:90}, 
                    {title:"Monto ejercido", field:"montoejer", width:90},
                    {title:"Responsable", field:"resp", width:100},
                    {title:"Comentarios", field:"comen", width:100},

                ],
             });
              
              //trigger an alert message when the row is clicked
             table.on("rowClick", function(e, row){ 
                  //alert("Row " + row.getData().id + " Clicked!!!!");
             });   

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
      table.download("xlsx", "informacion.xlsx", {sheetName:"Datos"});
        

  }

}
