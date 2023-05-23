import numeral from "numeral"

export class Formato{
   constructor(){}
   
   moneda(monto){
          return numeral(monto).format('$0,0.00')
   }

   unformat(monto){
    return numeral(monto).value()
   }
}