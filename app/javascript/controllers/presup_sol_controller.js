import { Controller } from "@hotwired/stimulus"
import numeral from "numeral"
//import { Presupuesto } from './presupuesto.js'
//import { SolicitaUtil  } from './solicita_util.js'
//import { Formato  } from './formato.js'



var token = document.querySelector('meta[name="csrf-token"]').content
var py_clasifca = ''
var py_ovh = ''
var monto_limite = 0.0

//var solUtil = new SolicitaUtil()
//var formato = new Formato()

export default class extends Controller {
    connect() {
        var proyecto = document.getElementById('presupuesto_proyecto_id')
        this.proyecto(proyecto)
    }
    campoformat(event){
          event.target.value = this.moneda(event.target.value)
    }

    campounformat(event){
         event.target.value = this.unformat(event.target.value)  
    }

    sumaMontoCaps(event){
        var total_caps = document.getElementById('total_caps')
        if ( this.limiteMaxGasto() ){
              event.target.value = ''
              alert("El monto total de capitulos no debe ser mayor al monto calculado para gastos")  
        }else{
              total_caps.innerHTML = this.moneda(this.solSumaCapitulos())
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
        this.limiteGasto(document.getElementById('presupuesto_tgastos').value)
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
        //var presupuesto = new Presupuesto(py_clasifca, py_ovh, formato.unformat(costo.value))

        var iva = 0.0
        var tProyecto = 0.0
        var porcOverhead = 0.0
        var porcEstimulo = 0.0
        var tGastos = 0.0
        
        if (clasifica.includes(py_clasifca) && Boolean(py_ovh) ){
               iva = this.iva(this.unformat(costo.value))
               tProyecto = this.tProyecto(this.unformat(costo.value))
               porcOverhead = this.porcOverhead(this.unformat(costo.value))
               porcEstimulo = this.porcEstimulo(this.unformat(costo.value))
               tGastos = this.tGastos(this.unformat(costo.value))
        }
        if (clasifica.includes(py_clasifca) && !Boolean(py_ovh)) {
               tGastos = costo.value
        }

        document.getElementById('presupuesto_iva').value =  this.moneda(iva)
        document.getElementById('presupuesto_tproyecto').value = this.moneda(tProyecto)
        document.getElementById('presupuesto_overhead').value = this.moneda(porcOverhead)
        document.getElementById('presupuesto_estimulo').value = this.moneda(porcEstimulo)
        document.getElementById('presupuesto_tgastos').value = this.moneda(tGastos)
 
    }

    ////////////////////////presupuesto///////////////
    iva(monto) {
        return parseFloat(monto) * .16
    }
    tProyecto(monto) {
        return parseFloat(monto) + parseFloat(this.monto) * .16
    }
    porcOverhead(monto) {
        return parseFloat(monto) * .20
    }
    porcEstimulo(monto) {
        return parseFloat(monto) * .10
    }
    tGastos(monto) {
        return parseFloat(monto) - ((parseFloat(monto) * .20) + (parseFloat(monto) * .10))
    }  
    //////////////////////////////////////

    ///////FORMATO///////////////////////////////
    moneda(monto) {
        return numeral(monto).format('$0,0.00')
    }

    unformat(monto) {
        return numeral(monto).value()
    }
    /////////////////////////////////////

    ////////////////Solicit_utils/////////////////////////
    limiteGasto(monto) {
        monto_limite = numeral(monto).value()
    }

    limiteMaxGasto() {
        if (this.solSumaCapitulos() > parseFloat(monto_limite)) {
            return true
        } else {
            return false;
        }
    }

    solSumaCapitulos() {
        var sum_caps = 0.0
        var caps = document.getElementsByClassName('capmonto')
        Array.from(caps, (el) => {
            let v = numeral(el.value).value()
            sum_caps += v
        })
        return sum_caps
    }
    ///////////////////////////////////////

}