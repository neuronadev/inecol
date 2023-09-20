import numeral from "numeral"

export default class Formato{
   constructor(){
               
   }
   
   moneda(monto, locale_p='es-MX', currency_p='MXN'){
           //return '€ ' + numeral(monto).format('0.0,00')
     
      var resultd = (numeral(monto).value()).toLocaleString(locale_p, {
         style: 'currency',
         currencyDisplay: 'code',
         currency: currency_p
      });
      
      return resultd
   }

   unformat(monto){
    return numeral(monto).value()
   }

   settingFormat(){
     
      numeral.locale('fr');

   }

}