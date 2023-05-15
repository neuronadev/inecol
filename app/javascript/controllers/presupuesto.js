export class Presupuesto{
    constructor(clasifica, ovh, monto){
          this.clasifica = clasifica
          this.ovh = ovh
          this.monto = monto
    }
    iva(){
        return parseFloat(this.monto) * .16
    }
    tProyecto(){
        return parseFloat(this.monto) + parseFloat(this.monto) * .16
    }
    porcOverhead(){
        return parseFloat(this.monto) * .20
    }
    porcEstimulo(){
        return  parseFloat(this.monto) * .10
    }
    tGastos(){
        return parseFloat(this.monto) - ( (parseFloat(this.monto) * .20) + (parseFloat(this.monto) * .10) )
    }

}