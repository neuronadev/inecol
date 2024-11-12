import { Controller } from "@hotwired/stimulus"
import numeral from "numeral"


// Connects to data-controller="impuestos"
export default class extends Controller {

  
  connect() {
      
  }

  cambiar(event){
      var target = document.getElementById("porc_impuesto")
      target.src = event.params.url
      target.reload()
  }

  cancelar(event){
      var target = document.getElementById("porc_impuesto")
      target.src = event.params.url
      target.reload()
  }

  costos_bd(){
      let costop = document.getElementById("costop").value
      let overhead = document.getElementById("overhead").value
      let estimulo = document.getElementById("estimulo").value
      let iva = document.getElementById("iva").value
      let totalgastos = document.getElementById("totalgastos").value
      let totalproyecto = document.getElementById("totalproyecto").value

      let costos_params = {
          p_costop: costop,
          p_overhead: overhead,
          p_estimulo: estimulo,
          p_iva: iva,
          p_totalgastos: totalgastos,
          p_totalproyecto: totalproyecto
      }

    return costos_params
      
  }

  eventOverhead(event){
      let params =  this.costos_bd()
      let mnto_overhead = this.calcOverhead( params, event.target.value )
      let mnto_estimulo = this.calcEstimulo( params, document.getElementById("impuesto_porc_estimulo").value )
      
      let total_gastos = this.totalGastos(params, { overhead: mnto_overhead, estimulo: mnto_estimulo })

      this.renderOverhead(mnto_overhead)
      this.renderTotalGastos(total_gastos)

      document.getElementById("overhead").value = mnto_overhead
      document.getElementById("totalgastos").value = total_gastos      

  } 

  eventEstimulo(event){
      let params =  this.costos_bd()
      let mnto_estimulo = this.calcEstimulo( params, event.target.value )
      let mnto_overhead = this.calcOverhead( params, document.getElementById("impuesto_porc_overhead").value )

      let total_gastos = this.totalGastos(params, { overhead: mnto_overhead, estimulo: mnto_estimulo })

      this.renderEstimulo(mnto_estimulo)
      this.renderTotalGastos(total_gastos)

      document.getElementById("estimulo").value = mnto_estimulo
      document.getElementById("totalgastos").value = total_gastos      
  }

  eventIva(event){
        let params =  this.costos_bd()

        if ( event.target.checked ){
               this.renderIva(0) 
               let total_proyecto = this.totalProyecto( params, 0 )
               this.renderTotalProyecto( total_proyecto )
               document.getElementById("impuesto_porc_iva").value = 0

               document.getElementById("iva").value = 0
               document.getElementById("totalproyecto").value = total_proyecto
        }else{
               let mto_iva = this.calcIva( params, 16.0 )
               this.renderIva(mto_iva)
               let total_proyecto = this.totalProyecto( params, 16.0 )
               this.renderTotalProyecto( total_proyecto )
               document.getElementById("impuesto_porc_iva").value = 16.0

               document.getElementById("iva").value = mto_iva
               document.getElementById("totalproyecto").value = total_proyecto
        }
  }

  calcOverhead( params, input_overhead){
      if ( input_overhead.trim() === "" ){
             input_overhead = 0.0
      }

      let mnto_overhead = parseFloat(params.p_costop) * parseFloat((input_overhead/100))
      return mnto_overhead
  } 

  calcEstimulo( params, input_estimulo ){
      if ( input_estimulo.trim() === "" ){
            input_estimulo = 0.0
      }

      let mnto_estimulo = parseFloat(params.p_costop) * parseFloat((input_estimulo/100))
      return mnto_estimulo
  }

  calcIva( params, porc_iva ){
      let mnto_iva = parseFloat(params.p_costop) * parseFloat((porc_iva/100))
      return mnto_iva
  }

  totalGastos( params, montos ){
      let total_gastos = params.p_costop - ( montos.overhead + montos.estimulo )
      return total_gastos
  }

  totalProyecto( params, porc_iva ){
      let total_proyecto = parseFloat(params.p_costop) + ( parseFloat(params.p_costop) * parseFloat((porc_iva/100)) )

      return total_proyecto
  }

  tipomoneda(){
      let lmoneda = document.getElementById("lmoneda").value
      let cmoneda = document.getElementById("cmoneda").value
      let smoneda = document.getElementById("smoneda").value

      return  { locale: lmoneda, currency:cmoneda, simbolo: smoneda }
  }

  formatmonto(moneda, monto){
      return ` ${moneda.currency} ${moneda.simbolo} ${numeral(monto).format('0,0.00')}`
  }

  renderOverhead(mnto_overhead){
     let moneda = this.tipomoneda()
     let str_monto_overhead = this.formatmonto(moneda, mnto_overhead)
     document.getElementById("monto_overhead").innerHTML = str_monto_overhead
  }

  renderEstimulo(mnto_estimulo){
    let moneda = this.tipomoneda()
    let str_monto_estimulo = this.formatmonto(moneda, mnto_estimulo)
    document.getElementById("monto_estimulo").innerHTML = str_monto_estimulo
  }

  renderTotalGastos( monto ){
        let moneda = this.tipomoneda()
        let str_monto_tgastos = this.formatmonto(moneda, monto)
        document.getElementById("total_gastos").innerHTML = str_monto_tgastos
  }

  renderIva( monto ){
    let moneda = this.tipomoneda()
    let str_monto_iva = this.formatmonto(moneda, monto)
    document.getElementById("monto_iva").innerHTML = str_monto_iva
  }

  renderTotalProyecto( monto ){
    let moneda = this.tipomoneda()
    let str_monto_tp = this.formatmonto(moneda, monto)
    document.getElementById("total_proyecto").innerHTML = str_monto_tp
  }


}