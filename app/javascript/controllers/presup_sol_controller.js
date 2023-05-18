import { Controller } from "@hotwired/stimulus"
import { Presupuesto } from './presupuesto.js'
import { SolicitaUtil  } from './solicita_util.js'

var token = document.querySelector('meta[name="csrf-token"]').content
var py_clasifca = ''
var py_ovh = ''
var solUtil = new SolicitaUtil()

export default class extends Controller {
    connect() {
        var proyecto = document.getElementById('presupuesto_proyecto_id')
        this.proyecto(proyecto)
    }

    sumaMontoCaps(event){
        if ( solUtil.limiteMaxGasto() ){
              event.target.value = ''
              alert("El monto total de capitulos no debe ser mayor al monto calculado para gastos")  
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
        var presupuesto = new Presupuesto(py_clasifca, py_ovh, costo.value)

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

        document.getElementById('presupuesto_iva').value =  iva
        document.getElementById('presupuesto_tproyecto').value = tProyecto
        document.getElementById('presupuesto_overhead').value = porcOverhead
        document.getElementById('presupuesto_estimulo').value = porcEstimulo
        document.getElementById('presupuesto_tgastos').value = tGastos
 
    }


}