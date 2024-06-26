import numeral from "numeral"


export default class SolicitaUtil{
   constructor(){
         this.monto_limite = 0.0
   }
    limiteGasto(monto){
        var monto_tmp = monto.toString().replace('GBP','') 
        this.monto_limite = numeral(monto_tmp).value()
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
           let id_input_d = el.id.replace("monto", "_destroy");
           let input_d = document.getElementById(id_input_d)
           if ( input_d.value == 'false' ){
               var monto_tmp = el.value.toString().replace('GBP','') 
               let v = numeral(monto_tmp).value()
               sum_caps += v
           }    
       })
       
       return sum_caps   
   }
}