import { Controller } from "@hotwired/stimulus"
import { Collapse } from 'flowbite';

// Connects to data-controller="menunavplan"
export default class extends Controller {
  connect() {
    const targetEl = document.getElementById('dropdownNavbar');
    // optionally set a trigger element (eg. a button, hamburger icon)
    const triggerEl = document.getElementById('dropdownNavbarLink');

    // optional options with default values and callback functions
    const options = {
      onCollapse: () => {},
      onExpand: () => {},
      onToggle: () => {}
    };
    const collapse = new Collapse(targetEl, triggerEl, options);
  }
  
}
