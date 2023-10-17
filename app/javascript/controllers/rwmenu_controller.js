import { Controller } from "@hotwired/stimulus"
import { Dropdown } from 'flowbite';

// Connects to data-controller="rwmenu"
export default class extends Controller {
  connect() {
        // set the dropdown menu element
        const targetEl = document.getElementById('dropdownDots');

        // set the element that trigger the dropdown menu on click
        const triggerEl = document.getElementById('dropdownMenuIconButton');

        // options with default values
        const options = {
              placement: 'bottom',
              triggerType: 'click',
              offsetSkidding: 0,
              offsetDistance: 10,
              delay: 300,
              ignoreClickOutsideClass: false,
              onHide: () => {
              },
              onShow: () => {
              },
              onToggle: () => {
              }
        };
        const dropdown = new Dropdown(targetEl, triggerEl, options);
        dropdown.hide();
  }
  
  
}
