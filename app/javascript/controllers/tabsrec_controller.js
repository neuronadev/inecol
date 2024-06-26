import { Controller } from "@hotwired/stimulus"
import { Tabs } from "flowbite"
import  Formato   from 'controllers/formato'
import numeral from "numeral"

var formato = new Formato()
var token = document.querySelector('meta[name="csrf-token"]').content
var currency = ''
// Connects to data-controller="tabspr"
export default class extends Controller {

    connect() {
        currency = document.getElementById('currency').value

        const tabElements = [
            {
                id: 'ffiscales',
                triggerEl: document.querySelector('#profile-tab-example'),
                targetEl: document.querySelector('#profile-example')
            },
            {
                id: 'aespecie',
                triggerEl: document.querySelector('#dashboard-tab-example'),
                targetEl: document.querySelector('#dashboard-example')
            },
            {
                id: 'fconcurrente',
                triggerEl: document.querySelector('#settings-tab-example'),
                targetEl: document.querySelector('#settings-example')
            }
        ];
        const options = {
            defaultTabId: 'ffiscales',
            activeClasses: 'text-blue-600 hover:text-blue-600 dark:text-blue-500 dark:hover:text-blue-400 border-blue-600 dark:border-blue-500',
            inactiveClasses: 'text-gray-500 hover:text-gray-600 dark:text-gray-400 border-gray-100 hover:border-gray-300 dark:border-gray-700 dark:hover:text-gray-300',
        };
        const tabs = new Tabs(tabElements, options);
    }

    campoformat(event){
          event.target.value = formato.moneda(event.target.value, '', currency)
    }

    campounformat(event){
         event.target.value = formato.unformat(event.target.value)
    }

    sumaMonto(event){
         var tffiscal = document.getElementById(event.params.ttarget) 
         var monto = this.sumaMontoRec(event.params.tclas)
        tffiscal.innerHTML = formato.moneda(monto, '', currency)

    }

    sumaMontoRec(t_class){
        var sum_caps = 0.0
        var caps = document.getElementsByClassName(t_class)
        Array.from(caps, (el) => {
            var monto_tmp = el.value.toString().replace('GBP','')
            let v = numeral(monto_tmp).value()
            sum_caps += v
        })
        return sum_caps   
    }

}
