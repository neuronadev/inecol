export default class Presupuesto{
    constructor(clasifica, ovh, monto){
          this.clasifica = clasifica
          this.ovh = ovh
          this.monto = monto
    }
    iva( tiva = 1, impuesto ){
         return parseFloat(this.monto) * parseFloat((impuesto.iva/100))
         /*if ( tiva == 1 ){
               return parseFloat(this.monto) * .16
         }
         if ( tiva == 2 ){
               return 0.0
         }   
         if ( tiva == 3 ){
            return 0.0
         } */  
    }
    tProyecto( tproy = 1, impuesto ){
           return parseFloat(this.monto) + parseFloat(this.monto) * parseFloat((impuesto.iva/100))

        /* if ( tproy == 1 ){
                  return parseFloat(this.monto) + parseFloat(this.monto) * .16
         }
         if ( tproy == 2 ){
               return parseFloat(this.monto)
         }
         if ( tproy == 3 ){
            return parseFloat(this.monto)
         }*/
    }
    porcOverhead( toverh = 1, impuesto ){
        return parseFloat(this.monto) * parseFloat((impuesto.overhead/100))
        /*if (toverh == 1){
              return parseFloat(this.monto) * .20
        }
        if (toverh == 2){
            return parseFloat(this.monto) * .0871
        }
        if (toverh == 3){
            return parseFloat(this.monto) * 0.1
        }*/
    } 
    porcEstimulo( testim = 1, impuesto ){
         return  parseFloat(this.monto) * parseFloat((impuesto.estimulo/100))
        /*if ( testim == 1 ){
                 return  parseFloat(this.monto) * .10
        }
        if ( testim == 2 ){
            return  0.0
        }
        if ( testim == 3 ){
            return  0.0
        }*/
    }
    tGastos( tgas = 1, impuesto ){
         return parseFloat(this.monto) - ( ( parseFloat(this.monto) * (impuesto.overhead/100) ) + ( parseFloat(this.monto) * (impuesto.estimulo/100) ) )
        /*if ( tgas == 1 ){ 
            return parseFloat(this.monto) - ( (parseFloat(this.monto) * .20) + (parseFloat(this.monto) * .10) )
        }
        if ( tgas == 2 ){ 
            return parseFloat(this.monto) - ( (parseFloat(this.monto) * .0871) )
        }    
        if ( tgas == 3 ){ 
            return parseFloat(this.monto) - ( (parseFloat(this.monto) * 0.1) )
        } */   
    }

}