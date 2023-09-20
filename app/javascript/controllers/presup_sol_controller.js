import { Controller } from "@hotwired/stimulus"
import  Presupuesto  from 'controllers/presupuesto'
import  SolicitaUtil   from 'controllers/solicita_util'
import  Formato   from 'controllers/formato'

var token = document.querySelector('meta[name="csrf-token"]').content
var py_clasifca = ''
var py_ovh = ''
var solUtil = new SolicitaUtil()
var formato = new Formato()
var moneda_data = ''
export default class extends Controller {
    connect() {
        var proyecto = document.getElementById('presupuesto_proyecto_id')
        this.proyecto(proyecto)
    }

    campoformat(event){
        /*if ( event.target.value.length > 0){
              event.target.value = formato.moneda(event.target.value, moneda_data.locale, moneda_data.currency)
        }else{
            event.target.value = '' 
        } */
        var costo = document.getElementById('presupuesto_costo')
        var costo_tmp = costo.value
        
        if (costo.value.length > 0) {
            costo.value = ''      
            costo.value = formato.moneda(costo_tmp, moneda_data.locale, moneda_data.currency)
        } else {
            costo.value = ''
        }    
    }

    itemformat(event){

         if ( event.target.value.length > 0){
               event.target.value = formato.moneda(event.target.value, moneda_data.locale, moneda_data.currency)
         }else{
                event.target.value = '' 
         }
    
        }


    campounformat(event){
         event.target.value = formato.unformat(event.target.value)  
    }

    sumaMontoCaps(event){
        var total_caps = document.getElementById('total_caps')
        solUtil.limiteGasto(document.getElementById('presupuesto_tgastos').value)
        if ( solUtil.limiteMaxGasto() ){
              event.target.value = ''
              alert("El monto total de capitulos no debe ser mayor al total para gastos")  
        }else{
              total_caps.innerHTML = formato.moneda(solUtil.solSumaCapitulos(), moneda_data.locale, moneda_data.currency)
        }

    }
    
    calcularGastos(event){
        var moneda_sel = document.getElementById('presupuesto_moneda_id')
        var monto_costo = document.getElementById('presupuesto_costo')

        if (moneda_sel.value != ''){
            if (monto_costo.value != '') {
                  this.costos()
                  this.setTgasto()
            }else{
                  alert('Debe ingresar el monto del costo del proyecto') 
            }
        }else{
               alert('Debe seleccionar un tipo de moneda')
        }
    } 

    setTgasto(event){
        solUtil.limiteGasto(document.getElementById('presupuesto_tgastos').value)
    }

  
    async TipoMoneda(event) { 
        let idmoneda = event.target.value
        var data = ''
          if ( idmoneda != ''){
                try {
                        data = await fetch('/monedas/data', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-Token': token },
                        body: JSON.stringify({ 'idmoneda': idmoneda })
                    })
                        .then(response => response.json())
                        .then(data => {
                                moneda_data = data
                                if (document.getElementById('presupuesto_costo').value.length > 0) {
                                     this.campoformat()
                                     this.costos()
                                }
                                
                        })
            
                } catch (e) { alert(e) }
              
          }       
    }  


    async proyecto(proyecto){
        try {
            var data = await fetch('/presupuestos/pyclasifica', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
                body: JSON.stringify({ proyecto_id:proyecto.value})
            })
                .then(response => response.json())
                .then(data => {
                         py_clasifca = data.clasifica
                         py_ovh = data.ovh
                })
        } catch (e) { alert(e) }
    }

    costos() {
        var clasifica = ['PSERV','INCUR', 'CREC']

        var costo = document.getElementById('presupuesto_costo')
        var presupuesto = new Presupuesto(py_clasifca, py_ovh, formato.unformat(costo.value))

        var iva = 0.0
        var tProyecto = 0.0
        var porcOverhead = 0.0
        var porcEstimulo = 0.0
        var tGastos = 0.0
        
       

        if (clasifica.includes(py_clasifca) && Boolean(py_ovh) ){
               iva = presupuesto.iva()
               tProyecto = presupuesto.tProyecto()
               porcOverhead = presupuesto.porcOverhead()
               porcEstimulo = presupuesto.porcEstimulo()
               tGastos = presupuesto.tGastos()
        }
        if (clasifica.includes(py_clasifca) && !Boolean(py_ovh)) {
               tGastos = costo.value
        }

        document.getElementById('presupuesto_iva').value = formato.moneda(iva, moneda_data.locale, moneda_data.currency)
        document.getElementById('presupuesto_tproyecto').value = formato.moneda(tProyecto, moneda_data.locale, moneda_data.currency)
        document.getElementById('presupuesto_overhead').value = formato.moneda(porcOverhead, moneda_data.locale, moneda_data.currency)
        document.getElementById('presupuesto_estimulo').value = formato.moneda(porcEstimulo, moneda_data.locale, moneda_data.currency)
        document.getElementById('presupuesto_tgastos').value = formato.moneda(tGastos, moneda_data.locale, moneda_data.currency)
 
    }


}