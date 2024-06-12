import { Controller } from "@hotwired/stimulus"
import SlimSelect from 'slim-select'

// Connects to data-controller="slimrp"
export default class extends Controller {
  static targets = ['field']
  connect() {
       var x = new SlimSelect({
            select: this.fieldTarget,
            settings: {
                showSearch: false,
            }    
       })
  }
}
