import { Controller } from "@hotwired/stimulus"
import  Presupuesto  from 'controllers/presupuesto'
import  SolicitaUtil   from 'controllers/solicita_util'
import  Formato   from 'controllers/formato'

var token = document.querySelector('meta[name="csrf-token"]').content
var clasifica = ['PSERV', 'INCUR', 'CREC']
var py_clasifca = ''
var py_ovh = ''
var solUtil = new SolicitaUtil()
var formato = new Formato()
var moneda_data = ''
export default class extends Controller {
    
    async connect() {
        var proyecto = document.getElementById('presupuesto_proyecto_id')
        var idmoneda = document.getElementById('presupuesto_moneda_id').value
       /* 
        if ( idmoneda != '' ){
              await this.Tmoneda(idmoneda)
        }
        await this.proyecto(proyecto)
        */
        await this.proyecto(proyecto).then(r=>{
            if ( idmoneda != '' ){
                 this.Tmoneda(idmoneda)
            }
        })
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
            if (monto_costo.value.length > 0) {
                  this.costos()
                  this.setTgasto()
            }else{
                  this.resetCostos()
            }
        }else{
               alert('Debe seleccionar un tipo de moneda')
        }
    } 

    resetCostos(){
        document.getElementById('presupuesto_iva').value = 0.0
        document.getElementById('presupuesto_tproyecto').value = 0.0
        document.getElementById('presupuesto_overhead').value = 0.0
        document.getElementById('presupuesto_estimulo').value = 0.0
        document.getElementById('presupuesto_tgastos').value = 0.0
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
                                     this.itemsCaps()
                                }
                                
                        })
            
                } catch (e) { alert(e) }
              
          }       
    } 
    async Tmoneda(idmoneda) {
        var data = ''
        if (idmoneda != '') {
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
                            this.itemsCaps()
                        }
                    })

            } catch (e) { alert(e) }

        }
    } 
    
    

    itemsCaps(){
        var caps = document.getElementsByClassName('capmonto')
        Array.from(caps, (el) => {
           let id_input_d = el.id.replace("monto", "_destroy");
           let input_d = document.getElementById(id_input_d)
           if ( input_d.value == 'false' ){
                el.value = formato.moneda(el.value, moneda_data.locale, moneda_data.currency)
           }    
        })
        var total_caps = document.getElementById('total_caps')
        solUtil.limiteGasto(document.getElementById('presupuesto_tgastos').value)
        total_caps.innerHTML = formato.moneda(solUtil.solSumaCapitulos(), moneda_data.locale, moneda_data.currency)
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
       
        var costo = document.getElementById('presupuesto_costo')
        var presupuesto = new Presupuesto(py_clasifca, py_ovh, formato.unformat(costo.value))
        var action_p = document.getElementById('action_p')
        console.log(action_p)

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
               tProyecto = costo.value
               tGastos = costo.value
        }

        if ( action_p.value != 'edit' && action_p.value != 'update' ){  //<- Se agrego para estimulo, Quitar o ajustar
            document.getElementById('presupuesto_iva').value = formato.moneda(iva, moneda_data.locale, moneda_data.currency)
            document.getElementById('presupuesto_tproyecto').value = formato.moneda(tProyecto, moneda_data.locale, moneda_data.currency)
            document.getElementById('presupuesto_overhead').value = formato.moneda(porcOverhead, moneda_data.locale, moneda_data.currency)
            document.getElementById('presupuesto_estimulo').value = formato.moneda(porcEstimulo, moneda_data.locale, moneda_data.currency)
            document.getElementById('presupuesto_tgastos').value = formato.moneda(tGastos, moneda_data.locale, moneda_data.currency)
        }else{
            document.getElementById('presupuesto_iva').value = formato.moneda(document.getElementById('presupuesto_iva').value, moneda_data.locale, moneda_data.currency)
            document.getElementById('presupuesto_tproyecto').value = formato.moneda( document.getElementById('presupuesto_tproyecto').value, moneda_data.locale, moneda_data.currency)
            document.getElementById('presupuesto_overhead').value = formato.moneda( document.getElementById('presupuesto_overhead').value, moneda_data.locale, moneda_data.currency)
            document.getElementById('presupuesto_estimulo').value = formato.moneda(document.getElementById('presupuesto_estimulo').value, moneda_data.locale, moneda_data.currency)
            document.getElementById('presupuesto_tgastos').value = formato.moneda(document.getElementById('presupuesto_tgastos').value, moneda_data.locale, moneda_data.currency)
        }      
 
    }


}