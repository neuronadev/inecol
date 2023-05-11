import NestedForm from "stimulus-rails-nested-form";

export default class extends NestedForm {
  connect() {
    super.connect();

  }
  add(event){
      super.add(event);
  }  

}