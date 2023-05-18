import NestedForm from "stimulus-rails-nested-form";
import { PartUtil } from './participan_util.js'

export default class extends NestedForm {
  connect() {
    super.connect();
  }
  remove(event) {
    var partUtil = new PartUtil('', '')
    super.remove(event);
    partUtil.mostrar_suma_porc()
  }
}