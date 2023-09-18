import { Controller } from "@hotwired/stimulus"
import { Accordion } from 'flowbite';

// Connects to data-controller="acordion"
export default class extends Controller {
  connect() {
      const accordionItems = [
            {
              id: 'accordion-arrow-icon-heading-1',
              triggerEl: document.querySelector('#accordion-arrow-icon-heading-1'),
              targetEl: document.querySelector('#accordion-arrow-icon-body-1'),
              active: false
            }
      ];
     const options = {
            alwaysOpen: true,
            activeClasses: 'bg-gray-100 dark:bg-gray-800 text-gray-900 dark:text-white',
            inactiveClasses: 'text-gray-500 dark:text-gray-400',

            onOpen: (item) => {
              console.log('accordion item has been shown');
              console.log(item);
            }
     }
    const accordion = new Accordion(accordionItems, options);
  }
}
