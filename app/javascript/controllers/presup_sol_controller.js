import { Controller } from "@hotwired/stimulus"
import  Presupuesto  from './presupuesto.js'
import  SolicitaUtil   from './solicita_util.js'
import  Formato   from './formato.js'

var token = document.querySelector('meta[name="csrf-token"]').content
var py_clasifca = ''
var py_ovh = ''
var solUtil = new SolicitaUtil()
var formato = new Formato()

export default class extends Controller {
    connect() {
        var proyecto = document.getElementById('presupuesto_proyecto_id')
        this.proyecto(proyecto)
    }
    campoformat(event){
          event.target.value = formato.moneda(event.target.value)
    }

    campounformat(event){
         event.target.value = formato.unformat(event.target.value)  
    }

    sumaMontoCaps(event){
        var total_caps = document.getElementById('total_caps')
        if ( solUtil.limiteMaxGasto() ){
              event.target.value = ''
              alert("El monto total de capitulos no debe ser mayor al total para gastos")  
        }else{
              total_caps.innerHTML = formato.moneda(solUtil.solSumaCapitulos())
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

        document.getElementById('presupuesto_iva').value =  formato.moneda(iva)
        document.getElementById('presupuesto_tproyecto').value = formato.moneda(tProyecto)
        document.getElementById('presupuesto_overhead').value = formato.moneda(porcOverhead)
        document.getElementById('presupuesto_estimulo').value = formato.moneda(porcEstimulo)
        document.getElementById('presupuesto_tgastos').value = formato.moneda(tGastos)
 
    }


}