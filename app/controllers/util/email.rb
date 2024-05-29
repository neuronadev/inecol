require 'rest-client'
require 'json'

module Util
    module Email

        def self.notificar(idproyecto, tipo)
               response = RestClient::Request.new(
                      :method => :post,
                      :url => 'localhost:4000/email/enviar',
                      :payload => {idproyecto: idproyecto, tipoenvio: tipo}
               ).execute
        end

    end   
end