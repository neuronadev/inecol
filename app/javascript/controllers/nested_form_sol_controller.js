import NestedForm from "stimulus-rails-nested-form";
import SolicitaUtil from 'controllers/solicita_util'
import Formato from 'controllers/formato'
var token = document.querySelector('meta[name="csrf-token"]').content
export default class extends NestedForm {
    connect() {
        super.connect();
    }
   async remove(event) {

        super.remove(event);
        
        var solUtil = new SolicitaUtil()
        var formato = new Formato()

        var total_caps = document.getElementById('total_caps')

        let idmoneda = document.getElementById('presupuesto_moneda_id').value

        if (idmoneda != '') {
            var moneda_data = await this.TipoMoneda(idmoneda)
        }
        
        solUtil.limiteGasto(document.getElementById('presupuesto_tgastos').value)
        total_caps.innerHTML = formato.moneda(solUtil.solSumaCapitulos(), moneda_data.locale, moneda_data.currency)
       
    }

    async TipoMoneda(idmoneda) {
            var data_r
            try {
                let datar = await fetch('/monedas/data', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-Token': token },
                    body: JSON.stringify({ 'idmoneda': idmoneda })
                })
                    .then(response => response.json())
                    .then(data => {
                        data_r = data
                })
            } catch (e) { alert(e) }
         return data_r    
    } 
    
}