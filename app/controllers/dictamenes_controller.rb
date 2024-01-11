class DictamenesController < ApplicationController
  def index
  end

  def new
      @dictamen = Dictamen.new
      @proyecto = Proyecto.find(params[:idpy])
  end

  def show
      @dictamen = Dictamen.find(params[:id])
      @proyecto = Proyecto.find(@dictamen.proyecto_id)
  end

  def create
      @dictamen = Dictamen.new(dictamen_params)
      @tvalidacion = Tvalidacion.find(params[:dictamen][:tvalidacion_id])
      @proyecto = Proyecto.find(params[:dictamen][:proyecto_id])

      enevento = Enevento.where(clave:'DICT').first  #Eventos de enlace

      if @tvalidacion.clave == 'ACEP'
            tevento = Tevento.where(clave:'ACEP').first
      else
            tevento = Tevento.where(clave:'RECH').first
      end      

      
      respond_to do |format|
            if @dictamen.save
                   Enlace.create!(proyecto_id:@proyecto.id, enevento_id:enevento.id)
                   Etapa.create!(proyecto_id:@proyecto.id, tevento_id:tevento.id)

                   emails = ['secretaria.academica@inecol.mx','secretaria.posgrado@inecol.mx','indra.morandin@inecol.mx','secretaria.tecnica@inecol.mx', 'sara.sanchez@inecol.mx']
                   current_time = Time.now
                   tiempo = (current_time.to_f * 1000).to_i
                   file_nm = "email_solfirma_#{tiempo.to_s}.txt"
                   path = "log/#{file_nm}"

                   File.open(path, 'w') do |file|
                      file.write(" <p>Estimado Comité Evaluador de Proyectos Externos</p>
                                 <p> Por medio del presente se hace de su conocimiento que se ha <b>DICTAMINADO<b> el siguiente proyecto:</p>
                                 <p><b>Proyecto:</b> #{@proyecto.nombre}</p>
                                 <p><b>Responsable:</b> #{@proyecto.persona.nom_espacio}</p>
                                 <p>Favor de ingresar al sistema para firmar.</p>

                                 <p><b>Enlace: <a href='https://sisproyectos.inecol.edu.mx/'>Ingresar al Sistema de Proyectos Externos</a></b>
                                 ")
                      end 

                      emails.each do |mail|
                                #`cat #{path} | mail -a "Content-Type: text/html; charset=UTF-8" -s "Proyecto dictaminado" -a 'Reply-To:sara.sanchez@inecol.mx' #{mail}`
                      end


                   format.html { redirect_to dictamen_path(@dictamen) } 
            else
                   flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                   format.html { render :new, status: :bad_request }
            end
      end
  end

  private
  def dictamen_params
      params.require(:dictamen).permit(:proyecto_id, :tvalidacion_id, :numregistro, :txtdictamen, :docdictamen)
  end
end
