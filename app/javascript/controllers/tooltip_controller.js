import { Controller } from "@hotwired/stimulus"
import { Tooltip } from 'flowbite';


// Connects to data-controller="tooltip"
export default class extends Controller {
  connect() {
  }
  
  txtHelp(event){
    const targetEl = document.getElementById('tip_costo');
    const triggerEl = document.getElementById('presupuesto_costo');
    const options = {
      placement: 'bottom',
      triggerType: 'hover'
    };
    const tooltip = new Tooltip(targetEl, triggerEl, options);
    tooltip.show();
  }
  
}
