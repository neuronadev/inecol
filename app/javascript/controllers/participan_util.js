import numeral from "numeral"

export default class PartUtil  {
    constructor(inputs_acad, inputs_tec) {
        this.inputs_acad = inputs_acad
        this.inputs_tec = inputs_tec

        this.limite_porc_part = 1
    }
    
    limiteMax(){
        if ((this.suma_invest() + this.suma_tec()) > this.limite_porc_part ){
                 return true 
         }else{
                 return false
         }
    }

    mostrar_suma_porc(){

        var tpinvest = document.getElementById('tpinvest')
        var stpinvest = document.getElementById('stpinvest')

        var tptec = document.getElementById('tptec')
        var stptec = document.getElementById('stptec')

        var tpf = document.getElementById('tpf')
        var total = 0.0

        tpinvest.innerHTML = numeral(this.suma_invest()).format('0%')
        stpinvest.innerHTML = numeral(this.suma_invest()).format('0%')

        tptec.innerHTML = numeral(this.suma_tec()).format('0%')
        stptec.innerHTML = numeral(this.suma_tec()).format('0%')

        tpf.innerHTML = numeral(this.suma_invest() + this.suma_tec()).format('0%')

    }

    suma_invest(){
        var sum_inves = 0.0 
        var poc_inves = document.getElementsByClassName('porinvest') 
        Array.from(poc_inves, (el) => {
                    let id_input_d = el.id.replace("porcentaje", "_destroy");
                    let input_d = document.getElementById(id_input_d)
                    
                    if ( input_d.value == 'false' ){
                            let v = numeral(el.value).value() / 100
                            sum_inves += v
                    }      
        })
      return sum_inves  
    }

    suma_tec(){
        var sum_tec = 0.0
        var poc_tec = document.getElementsByClassName('portec')
        Array.from(poc_tec, (el) => {
            let id_input_d = el.id.replace("porcentaje", "_destroy");
            let input_d = document.getElementById(id_input_d)

            if (input_d.value == 'false') {
                    let v = numeral(el.value).value() / 100
                    sum_tec += v
            }       
        })
      return sum_tec
    }

}