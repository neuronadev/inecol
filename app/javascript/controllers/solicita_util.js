import numeral from "numeral"

export class SolicitaUtil {
   constructor(){
         this.monto_limite = 0.0
   }
    limiteGasto(monto){
        this.monto_limite = numeral(monto).value()
    }

   limiteMaxGasto(){
        if (this.solSumaCapitulos() > parseFloat(this.monto_limite) ){
                return true
        }else{
                return false;
        }
   } 

   solSumaCapitulos(){
       var sum_caps = 0.0
       var caps = document.getElementsByClassName('capmonto')
       Array.from(caps, (el) => {
           let v = numeral(el.value).value()
           sum_caps += v
       })
       return sum_caps   
   }
}