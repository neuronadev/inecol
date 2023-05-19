import { Controller } from '@hotwired/stimulus'

export default class extends Controller {

    static targets = ['targeta', 'templatea']
    static values = {
        wrapperSelector: {
            type: String,
            default: '.nested-form-wrapper-a'
        }
    }

    add(event) {
        event.preventDefault()
        var content = this.templateaTarget.innerHTML.replace(/NEWA_RECORDA_A/g, new Date().getTime().toString())
        this.targetaTarget.insertAdjacentHTML('beforebegin', content)
    }

    remove(event){
        const wrapper = event.target.closest(this.wrapperSelectorValue)
        if (wrapper.dataset.newRecord === 'true') {
                 wrapper.remove()
        }else {
            wrapper.style.display = 'none'
            const input = wrapper.querySelector("input[name*='_destroy']")
            input.value = '1'
        }
        
    }

    
}