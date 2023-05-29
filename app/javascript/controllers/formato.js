import { Controller } from "@hotwired/stimulus"
import numeral from "numeral"

export class Formato extends Controller {
  
   moneda(monto){
          return numeral(monto).format('$0,0.00')
   }

   unformat(monto){
    return numeral(monto).value()
   }
}