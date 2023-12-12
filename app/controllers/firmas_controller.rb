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
      
      data = "proyecto:" + "|" + @proyecto.id.to_s + "|" + "numregistro:" + "|" + @proyecto.dictamen.numregistro + "|" + "user:" + current_usuario.email + "|" + "fecha:" + Time.now.to_s
      enc   = Base64.encode64(data)
      enc_j = {s:enc, nombre:current_usuario.cuenta.persona.nom_espacio}
 
      r = Firma.create!(evaluador_id: current_usuario.cuenta.persona.evaluador.id, proyecto_id: @proyecto.id, firmado:true, data:enc)
            
      respond_to do |format|
            format.json { render json:enc_j}
      end

  end

end
