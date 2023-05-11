import { Controller } from "@hotwired/stimulus"
import { Tabs } from "flowbite"

const tabElements = [
   {
      id: 'investigadores',
      triggerEl: document.querySelector('#profile-tab-example'),
      targetEl: document.querySelector('#profile-example')
   },
   {
        id: 'tecnicos',
        triggerEl: document.querySelector('#dashboard-tab-example'),
        targetEl: document.querySelector('#dashboard-example')
    },
    {
        id: 'estudiantes',
        triggerEl: document.querySelector('#settings-tab-example'),
        targetEl: document.querySelector('#settings-example')
    }
];
const options = {
  defaultTabId: 'investigadores',
  activeClasses: 'text-blue-600 hover:text-blue-600 dark:text-blue-500 dark:hover:text-blue-400 border-blue-600 dark:border-blue-500',
  inactiveClasses: 'text-gray-500 hover:text-gray-600 dark:text-gray-400 border-gray-100 hover:border-gray-300 dark:border-gray-700 dark:hover:text-gray-300',
  
};
// Connects to data-controller="tabspr"
export default class extends Controller {
  
  connect() {
      const tabs = new Tabs(tabElements, options);
  }
}
