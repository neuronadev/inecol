import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="organizar"
export default class extends Controller {
   
   connect() {}

   handleDrop(e) {
    e.stopPropagation(); // stops the browser from redirecting.
    //if (dragSrcEl !== this) {
      //dragSrcEl.innerHTML = this.innerHTML;
      e.target.innerHTML = e.dataTransfer.getData('text/html');
    //}
    return false;
   }
     
}
