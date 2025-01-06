// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'flowbite'
import "trix"
import "@rails/actiontext"


//import {TabulatorFull as Tabulator} from 'tabulator-tables';
//window.Tabulator = Tabulator


import * as XLSX from 'xlsx';
window.XLSX = XLSX

addEventListener("trix-initialize", (event) => {
    //configTrix();
    //extendTrix(event);
    //console.log("Event trix")
})

window.process = {
    env: {
        NODE_ENV: 'development'
    }
}