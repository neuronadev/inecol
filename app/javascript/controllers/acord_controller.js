import { Controller } from "@hotwired/stimulus"
import { Accordion } from 'flowbite';

export default class extends Controller {

  connect() {
      const accordionItems = [
          {
              id: 'accordion-collapse-heading-1',
              triggerEl: document.querySelector('#accordion-collapse-heading-1'),
              targetEl: document.querySelector('#accordion-collapse-body-1'),
              active: true
          },
          {
              id: 'accordion-collapse-heading-2',
              triggerEl: document.querySelector('#accordion-collapse-heading-2'),
              targetEl: document.querySelector('#accordion-collapse-body-2'),
              active: false
          },
          {
              id: 'accordion-collapse-heading-3',
              triggerEl: document.querySelector('#accordion-collapse-heading-3'),
              targetEl: document.querySelector('#accordion-collapse-body-3'),
              active: false
          }
      ];
      const options = {
          alwaysOpen: true,
          activeClasses: 'bg-gray-100 dark:bg-gray-800 text-gray-900 dark:text-white',
          inactiveClasses: 'text-gray-500 dark:text-gray-400'
      };
  
      const accordion = new Accordion(accordionItems, options);
       
   }
}    