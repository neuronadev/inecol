import { Controller } from "@hotwired/stimulus"
import { Tooltip } from 'flowbite';


// Connects to data-controller="tooltip"
export default class extends Controller {
  connect() {
       var targetEl = document.getElementById('tipTransCont');
       var triggerEl = document.getElementById('tipTrans');
       const options = {
            placement: 'bottom',
            triggerType: 'hover',
            placement: 'top',
            onHide: () => {
                //console.log('tooltip is shown');
            },
            onShow: () => {
                //console.log('tooltip is hidden');
            },
            onToggle: () => {
                //console.log('tooltip is toggled');
            },
       };
       const tooltip = new Tooltip(targetEl, triggerEl, options);
      
  }
}
