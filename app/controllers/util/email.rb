require 'sendgrid-ruby'
include SendGrid
module Util
    module Email  
        def self.proyecto_enlace(params)
                 to = Cuenta.includes(:rol).where('roles.clave':'EL').first.persona.email #Correo del enlace
                 puts 'Correo a: -----------------------'
                 puts to
                 from = 'proyecto.externo@inecol.mx'
                 template_id = 'd-a588d4f9befe40cdb1aa4d32b02d20f4'
                 data = {
                            "personalizations": [{
                                "to": [
                                        {
                                           "email": to
                                        }
                                       ],
                                       "dynamic_template_data": params
                                }],
                             "from": {
                                        "email": from
                                      },
                             "template_id": template_id
                        }
                sg = SendGrid::API.new(api_key: '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')
                response = sg.client.mail._('send').post(request_body: data)

               return {status:response.status_code, body:response.body, headers:response.headers }
        end

        def self.proyecto_responsable(params, proyid)
            to = Proyecto.find(proyid).persona.email #Correo del responsable del proyecto
            puts 'Correo a: -----------------------'
            puts to
            from = 'proyecto.externo@inecol.mx'
            template_id = 'd-3b06515812ce4992ae0ed798fe743a57'
            data = {
                       "personalizations": [{
                           "to": [
                                   {
                                      "email": to
                                   }
                                  ],
                                  "dynamic_template_data": params
                           }],
                        "from": {
                                   "email": from
                                 },
                        "template_id": template_id
                   }
           sg = SendGrid::API.new(api_key: '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')
           response = sg.client.mail._('send').post(request_body: data)

          return {status:response.status_code, body:response.body, headers:response.headers }
   end
    end   
end