import { Controller } from "@hotwired/stimulus"
import { Modal } from 'flowbite';

var modal
// Connects to data-controller="modalobs"
export default class extends Controller {
  connect() {

      
  }
  
  verobs(event){
           // set the modal menu element
           const targetEl = document.getElementById('crypto-modal');
           console.log(targetEl)
           // options with default values
           const options = {
               placement: 'bottom-right',
               backdrop: 'dynamic',
               backdropClasses: 'bg-gray-900 bg-opacity-50 dark:bg-opacity-80 fixed inset-0 z-40',
               closable: true,
               onHide: () => {
                   console.log('modal is hidden');
               },
               onShow: () => {
                   console.log('modal is shown');
               },
               onToggle: () => {
                   console.log('modal has been toggled');
               }
           }; 
      modal = new Modal(targetEl, options);
      // show the modal
      modal.show();
  }
  cerrar(event){
    modal.hide();
  }


}