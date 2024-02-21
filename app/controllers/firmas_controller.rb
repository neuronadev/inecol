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

      cargo_actual = current_usuario.cuenta.persona.cargo.tipocargo.clave 
      r = Firma.create!(evaluador_id: current_usuario.cuenta.persona.evaluador.id, 
                            proyecto_id: @proyecto.id, 
                            firmado: true, 
                            data: Base64.encode64(signature), 
                            clave: Base64.encode64(key_pair.to_s), 
                            tipo: 'KPAIRYB64',
                            firmasign: Base64.encode64(signature.unpack('H*')[0]),
                            cargoeval:cargo_actual
                          )
      if ( @proyecto.firmas.count() == 4 )
            enevento = Enevento.where(clave:'FIR').first
            Enlace.create(proyecto_id:@proyecto.id, enevento_id:enevento.id, estado:'C') 
            msg = " <p><b>Estimado(a) Investigador(a).</b></p>
                                   <p> Por medio del presente se hace de su conocimiento que ya se encuentra firmada la ficha del proyecto:</p>
                                   <p><b>Proyecto:</b> #{@proyecto.nombre}</p>
                                   <p><b>Responsable:</b> #{@proyecto.persona.nom_espacio}</p>
                                   <p><b>Enlace: <a href='https://sisproyectos.inecol.edu.mx/'>Ingresar al Sistema de Proyectos Externos</a></b>"
            p = @proyecto.persona
            c = Cuenta.where(persona_id:p.id).first
            u = Usuario.find(c.usuario_id) 
            m = u.email
            Thread.new{
                 `(sleep 20;echo "<html><body style='font-size:14px;font-family: Arial, Helvetica, sans-serif;'>#{msg}</body></html>" | mail -a "Content-Type: text/html; charset=UTF-8" -s "Ficha Firmada-#{@proyecto.persona.nom_espacio}-#{@proyecto.nombre[0..20]}" -a 'Reply-To:sara.sanchez@inecol.mx' #{m}) &`
            }
            Thread.new{
                 `(sleep 60;echo "<html><body style='font-size:14px;font-family: Arial, Helvetica, sans-serif;'>#{msg}</body></html>" | mail -a "Content-Type: text/html; charset=UTF-8" -s "Ficha Firmada-#{@proyecto.persona.nom_espacio}-#{@proyecto.nombre[0..20]}" -a 'Reply-To:no-reply@inecol.mx' sara.sanchez@inecol.mx) &`
            }
      end

      respond_to do |format|
                    format.json { render json:{s:Base64.encode64(signature.unpack('H*')[0]), nombre:current_usuario.cuenta.persona.nom_espacio} }
      end

  end

end
