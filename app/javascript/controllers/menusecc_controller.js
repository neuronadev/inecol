import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menusecc"
export default class extends Controller {
  connect() {}

  itemaction(event){
    var items_li = document.getElementsByClassName('itemli')
    for (let i = 0; i < items_li.length; i++) {
      items_li[i].classList.remove('font-semibold', 'text-gray-800')
    }
    event.target.closest('li').classList.add('font-semibold', 'text-gray-800')
  }
}
