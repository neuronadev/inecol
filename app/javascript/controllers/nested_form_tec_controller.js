import NestedForm from "stimulus-rails-nested-form";
import  PartUtil  from 'controllers/participan_util'

export default class extends NestedForm {
  connect() {
    super.connect();
  }

  add(event){
    super.add(event);
    this.disableOption()
  }  

  remove(event) {
    var partUtil = new PartUtil('', '')
    super.remove(event);
    partUtil.mostrar_suma_porc()
    this.disableOption()
  }

  disableOption(){
    let tipo = 'selecttect'
    let values = []
    const elements = document.querySelectorAll(`[data-class="${tipo}"]`)
    for (let elem of elements){
          if ( elem.value != '' ){
                values.push(elem.value)
          } 
    }
    for (let elem of elements){
          let value_act = elem.value
          for (let option of elem.options) {
                    if ( values.includes(option.value) ){
                            option.disabled = true;
                    }else{
                            option.disabled = false;
                    }
          }
    }
  }

}