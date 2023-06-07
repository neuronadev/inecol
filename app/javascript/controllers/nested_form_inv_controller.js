import NestedForm from "stimulus-rails-nested-form";
import  PartUtil  from 'controllers/participan_util'

export default class extends NestedForm {
  connect() {
    super.connect();
    
    
  }
  add(event){
      super.add(event);
  }  

  remove(event){
     var partUtil = new PartUtil('', '')
     super.remove(event);
     partUtil.mostrar_suma_porc()
  }

}