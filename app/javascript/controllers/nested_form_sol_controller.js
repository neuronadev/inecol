import NestedForm from "stimulus-rails-nested-form";
import SolicitaUtil from 'controllers/solicita_util'
import Formato from 'controllers/formato'
var token = document.querySelector('meta[name="csrf-token"]').content
export default class extends NestedForm {
    connect() {
        super.connect();
    }
    remove(event) {
        console.log("Eliminar..")
        super.remove(event);
        
        var solUtil = new SolicitaUtil()
        var formato = new Formato()

        var total_caps = document.getElementById('total_caps')
        var moneda_data = this.TipoMoneda()

        solUtil.limiteGasto(document.getElementById('presupuesto_tgastos').value)
        total_caps.innerHTML = formato.moneda(solUtil.solSumaCapitulos(), moneda_data.locale, moneda_data.currency)
       
    }

    async TipoMoneda() {
        let idmoneda = document.getElementById('presupuesto_moneda_id').value
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
                        return data
                })
                return data
            } catch (e) { alert(e) }
        }
    } 
    
}