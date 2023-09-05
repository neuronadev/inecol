require 'sendgrid-ruby'
include SendGrid
module Util
    module Email  
        def self.proyecto_enlace(to, from, params, template_id)
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
                sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
                response = sg.client.mail._('send').post(request_body: data)

               return {status:response.status_code, body:response.body, headers:response.headers }
        end
    end   
end