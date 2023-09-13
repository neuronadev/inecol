import { Controller } from "@hotwired/stimulus"
import { Dropdown } from 'flowbite';

export default class extends Controller {
  connect() {
      // set the dropdown menu element
      const targetEl = document.getElementById('dropdownDots');

      // set the element that trigger the dropdown menu on click
      const triggerEl = document.getElementById('dropdownMenuIconButton');

      const options = {
         placement: 'bottom',
         triggerType: 'click',
         offsetSkidding: 0,
         offsetDistance: 10,
         delay: 300,
         ignoreClickOutsideClass: false
      }
     const dropdown = new Dropdown(targetEl, triggerEl, options);
  }
}
