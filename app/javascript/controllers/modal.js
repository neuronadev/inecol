import { Modal } from 'flowbite';

export default class WModal {
   
    constructor(el){
        this.targetEl = el
        this.options = {
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
        this.modal = new Modal(this.targetEl, this.options);
    }

    mostrar(){
          this.modal.show()
    }
    cerrar(){
          this.modal.hide();
    }
        
}