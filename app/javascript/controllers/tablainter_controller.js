import { Controller } from "@hotwired/stimulus"
import {TabulatorFull as Tabulator} from 'tabulator-tables';

var token = document.querySelector('meta[name="csrf-token"]').content
var items = []
var table 
// Connects to data-controller="tabla"
export default class extends Controller {
 async connect() {
               
        //create Tabulator on DOM element with id "example-table"        
        await this.proyinter().then(d=>{
             items = d
                table = new Tabulator("#example-table", {
                spreadsheet:true,
                spreadsheetOutputFull: true,
                height:405, // set height of table (in CSS or here), this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
                data:d, //assign data to table
                layout:"fitColumns", //fit columns to width of table (optional)
                columns:[ //Define Table Columns
                    {title:"Título del proyecto", field:"nombre", width:280},
                    {title:"Fuente", field:"fuente", width:180},
                    {title:"Responsable", field:"resp", width:100},
                    {title:"Monto autorizado", field:"montoaut", width:90}, 
                    {title:"Instituciones part", field:"inst", width:100},
                    {title:"Fecha de inicio", field:"finicio", width:100},
                    {title:"Fecha de termino", field:"ftermino", width:100}, 
                    {title:"Estatus", field:"status", width:100}

                ],
             });
              
              //trigger an alert message when the row is clicked
             table.on("rowClick", function(e, row){ 
                  //alert("Row " + row.getData().id + " Clicked!!!!");
             });   

        })
        
  }

  async proyinter(){
        try {
            var data = await fetch('/reportes/pinvinter', {
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
