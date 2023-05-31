import { Controller } from "@hotwired/stimulus"
import { Tooltip } from 'flowbite';


 var targetEl = ''
 var triggerEl = ''
// Connects to data-controller="tooltip"
export default class extends Controller {
  connect() {
      targetEl = document.getElementById('tooltipContent');
      triggerEl = document.getElementById('tooltipButton');
  }
  
  txtHelp(event){
   
    const options = {
      placement: 'bottom',
      triggerType: 'hover'
    };
    const NODE_ENV = process.env.NODE_ENV
    const tooltip = new Tooltip(targetEl, triggerEl, options);
    tooltip.show();
  }
  
}
