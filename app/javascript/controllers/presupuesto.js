export default class Presupuesto{
    constructor(clasifica, ovh, monto){
          this.clasifica = clasifica
          this.ovh = ovh
          this.monto = monto
    }
    iva( tiva = 1 ){
         if ( tiva == 1 ){
               return parseFloat(this.monto) * .16
         }
         if ( tiva == 2 ){
               return 0.0
         }   
    }
    tProyecto( tproy = 1 ){
         if ( tproy == 1 ){
                  return parseFloat(this.monto) + parseFloat(this.monto) * .16
         }
         if ( tproy == 2 ){
               return parseFloat(this.monto)
         }         
    }
    porcOverhead( toverh = 1 ){
        if (toverh == 1){
              return parseFloat(this.monto) * .20
        }
        if (toverh == 2){
            return parseFloat(this.monto) * .0871
        }   
    } 
    porcEstimulo( testim = 1 ){
        if ( testim == 1 ){
                 return  parseFloat(this.monto) * .10
        }
        if ( testim == 2 ){
            return  0.0
         }                  
    }
    tGastos( tgas = 1 ){
        if ( tgas == 1 ){ 
            return parseFloat(this.monto) - ( (parseFloat(this.monto) * .20) + (parseFloat(this.monto) * .10) )
        }
        if ( tgas == 2 ){ 
            return parseFloat(this.monto) - ( (parseFloat(this.monto) * .0871) )
        }    
    }

}