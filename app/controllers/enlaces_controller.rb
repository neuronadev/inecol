class EnlacesController < ApplicationController
  def index
  end

  def show
      @enlace = Enlace.find(params[:id])
  end

  def new
    @enlace = Enlace.new
    @proyecto = Proyecto.find(params[:idpy])
    @enevento = Enevento.where(clave:params[:tipo]).first
    @tipo = params[:tipo]
  end

  def create
      @enlace = Enlace.new(enlace_params)
      @proyecto = Proyecto.find(params[:enlace][:proyecto_id])
      @enevento = Enevento.find(params[:enlace][:enevento_id])
      @tipo = @enevento.clave

      if @proyecto.enlaces.last.enevento.clave == 'PROC'
            enlace_last = Enlace.find(@proyecto.enlaces.last.id)
            enlace_last.estado = 'C'
            enlace_last.save
      end

      respond_to do |format|
            if @enlace.save
                   #format.html { redirect_to resumen_vistas_path(:id=>@proyecto.id) } 
                   #message  = ResponsableMailer.with(p:@proyecto, e:@enlace).notificar_corregir
                   #message.deliver_later

                   p = @proyecto.persona
                   c = Cuenta.where(persona_id:p.id).first
                   u = Usuario.find(c.usuario_id) 
                   m = u.email 

                   current_time = Time.now
                   tiempo = (current_time.to_f * 1000).to_i
                   file_nm = "email_solcorr_#{tiempo.to_s}.txt"
                   path = "log/#{file_nm}"

                   File.open(path, 'w') do |file|
                            file.write("<html><body style='font-size:14px;font-family: Arial, Helvetica, sans-serif;'>
                                        <p>Favor de atender la siguiente solicitud.</p>
                                        <p><b>Proyecto:</b> #{@proyecto.nombre}</p>
                                        <p><b>Solicitud:</b> #{@enlace.txtcoment}</p>
                                        </body></html>")
                   end 
                   Thread.new  { 
                      `(sleep 15;cat #{path} | mail -a "Content-Type: text/html; charset=UTF-8" -s "Corregir Proyecto" -a 'Reply-To:no-reply@inecol.mx' #{m}) &`
                   }    

                   format.html { redirect_to enlace_path(@enlace) }
            else
                   flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                   format.html { render :new, status: :bad_request }
            end
      end
  end

  def mensaje
      @proyecto = Proyecto.find(params[:idpy])
  end

  def atendido
      enlace = Enlace.find(params[:enlace_id])
      
      #########################################################################
      @proyecto = Proyecto.find(enlace.proyecto_id)
      enlace_py = enlace.proyecto_id
      enevento = Enevento.where(clave:'SOLA').first

      enlace.estado = 'C'
      enlace.save
      e1 = Enlace.create(proyecto_id:enlace_py, enevento_id:enevento.id, estado:'C', raiz:enlace.id) 
      #########################################################################
      enevento_proc = Enevento.where(clave:'PROC').first
      Enlace.create(proyecto_id:enlace_py, enevento_id:enevento_proc.id, estado:'C', raiz:e1.id) 
      ########################################################################
            
      current_time = Time.now
      tiempo = (current_time.to_f * 1000).to_i
      file_nm = "email_atendido_#{tiempo.to_s}.txt"
      path = "log/#{file_nm}"

      File.open(path, 'w') do |file|
             file.write("<html><body style='font-size:14px;font-family: Arial, Helvetica, sans-serif;'>Estimada Sara. <br><br>
                         El académico: <b> #{@proyecto.persona.nom_espacio} </b> ha <b>corregido</b> la solicitud enviada.<br>
                         <b>Nombre del proyecto:</b> #{@proyecto.nombre}<br>
                         <b>Solicitud:</b> #{enlace.txtcoment}
                        </body></html>")
       end 
       Thread.new  { 
          `(sleep 15;cat #{path} | mail -a "Content-Type: text/html; charset=UTF-8" -s "Proyecto corregido-#{@proyecto.persona.nom_espacio}-#{@proyecto.nombre[0..20]}" -a 'Reply-To:no-reply@inecol.mx' sara.sanchez@inecol.mx) &`
       }
      data = {result:'ok'}
      respond_to do |format|
          format.json { render json:data.to_json }
      end

  end

  def enterado
    enlace = Enlace.find(params[:enlace_id])

    enlace_py = enlace.proyecto_id
    enevento = Enevento.where(clave:'PROC').first

    enlace.estado = 'C'
    enlace.save

    Enlace.create(proyecto_id:enlace_py, enevento_id:enevento.id, estado:'A', raiz:enlace.id) 

    data = {result:'ok'}
    respond_to do |format|
        format.json { render json:data.to_json }
    end

end

  private
  def enlace_params
      params.require(:enlace).permit(:proyecto_id, :enevento_id, :txtcoment, :estado)
  end

end
