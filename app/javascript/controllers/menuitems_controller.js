import { Controller } from "@hotwired/stimulus"
import { Dropdown } from 'flowbite';

// Connects to data-controller="menuitems"
export default class extends Controller {
  connect() {
    console.log("Load controller")
          const targetEl = document.getElementById('dropdownSmall');
          const triggerEl = document.getElementById('dropdownSmallButton');
          const options = {
               placement: 'bottom',
               triggerType: 'click',
               offsetSkidding: 0,
               offsetDistance: 10,
               delay: 300,
               ignoreClickOutsideClass: false,
               onHide: () => {},
               onShow: () => {},
               onToggle: () => {},
           };
           
           // instance options object
           const instanceOptions = {
             id: 'dropdownDots',
             override: true
           };

           const dropdown = new Dropdown(targetEl, triggerEl, options, instanceOptions);
  }
}
