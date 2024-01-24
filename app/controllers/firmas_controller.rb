require 'openssl'
require 'json'
require 'base64'

class FirmasController < ApplicationController
  def index
  end

  def show
       @proyecto = Proyecto.find(params[:id])
  end

  def new
  end

  def create
  end

  def generar
      @proyecto = Proyecto.find(params[:proyecto_id])
      
      #data = "proyecto:" + "|" + @proyecto.id.to_s + "|" + "numregistro:" + "|" + @proyecto.dictamen.numregistro + "|" + "user:" + current_usuario.email + "|" + "fecha:" + Time.now.to_s

      data = { proyecto:@proyecto.id, numregistro: @proyecto.dictamen.numregistro, user: current_usuario.email, nombre:current_usuario.cuenta.persona.nom_espacio, fecha: Time.now.to_s }

      key_pair = OpenSSL::PKey::RSA.generate(2048)
      signature = key_pair.sign(OpenSSL::Digest::SHA256.new,data.to_json)

      r = Firma.create!(evaluador_id: current_usuario.cuenta.persona.evaluador.id, 
                            proyecto_id: @proyecto.id, 
                            firmado: true, 
                            data: Base64.encode64(signature), 
                            clave: Base64.encode64(key_pair.to_s), 
                            tipo: 'KPAIRYB64',
                            firmasign: Base64.encode64(signature.unpack('H*')[0])
                          )
      if ( @proyecto.firmas.count() == 4 )
            enevento = Enevento.where(clave:'FIR').first
            Enlace.create(proyecto_id:@proyecto.id, enevento_id:enevento.id, estado:'C') 
      end 

      respond_to do |format|
                    format.json { render json:{s:Base64.encode64(signature.unpack('H*')[0]), nombre:current_usuario.cuenta.persona.nom_espacio} }
      end

  end

end
