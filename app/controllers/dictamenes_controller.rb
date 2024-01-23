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

                    str_comite = " <p><b>Estimados Integrantes de Proyectos Externos:</b></p>
                                   <p> Por medio del presente se hace de su conocimiento que se ha <b>DICTAMINADO</b> el siguiente proyecto:</p>
                                   <p><b>Proyecto:</b> #{@proyecto.nombre}</p>
                                   <p><b>Responsable:</b> #{@proyecto.persona.nom_espacio}</p>
                                   <p>Favor de ingresar al sistema para firmar.</p>
                                   <p><b>Enlace: <a href='https://sisproyectos.inecol.edu.mx/'>Ingresar al Sistema de Proyectos Externos</a></b>" 

                    current_time = Time.now
                    tiempo = (current_time.to_f * 1000).to_i
                    file_nm = "email_dictamen_#{tiempo.to_s}.txt"
                    path = "log/#{file_nm}"
                    File.open(path, 'w') do |file|
                        file.write("<html><body style='font-size:15px;font-family: Arial, Helvetica, sans-serif;'>
                                     #{@dictamen.txtdictamen}
                                     <p><b>Enlace: <a href='https://sisproyectos.inecol.edu.mx/'>Ingresar al Sistema de Proyectos Externos</a></b>
                                    </body></html>")
                    end

                    p = @proyecto.persona
                    c = Cuenta.where(persona_id:p.id).first
                    u = Usuario.find(c.usuario_id) 
                    m = u.email  #---------------------------------------------


                    emails_comite = ['secretaria.academica@inecol.mx','secretaria.posgrado@inecol.mx','indra.morandin@inecol.mx','rosario.landgrave@inecol.mx', 'sara.sanchez@inecol.mx'] #------------------
                    espacios = [20,40,60,80,100]

                    emails_otros = []
                    if !params[:dictamen][:otrose].nil?
                        emails_tmp = params[:dictamen][:otrose].split(/\n/)
                        emails_tmp.each do |em|
                            if !(em.gsub(/\r/, "")=~ URI::MailTo::EMAIL_REGEXP).nil?
                                emails_otros << em  
                            end
                        end
                   end
                 
                    #COMITE
                    i = 0
                    emails_comite.each do |ecom|
                        t = espacios[i]  
                        Thread.new  {               
                            `(sleep #{t.to_s};echo "<html><body style='font-size:14px;font-family: Arial, Helvetica, sans-serif;'>#{str_comite}</body></html>" | mail -a "Content-Type: text/html; charset=UTF-8" -s "Firmar Ficha-#{@proyecto.persona.nom_espacio}-#{@proyecto.nombre[0..20]}" #{ecom}) &`
                         }
                    i = i+1     
                    end

                    #RESPONSBLE
                    Thread.new  {               
                        `(sleep 120;cat #{path} | mail -a "Content-Type: text/html; charset=UTF-8" -s "Dictamen de Proyecto-#{@proyecto.persona.nom_espacio}-#{@proyecto.nombre[0..20]}" sara.sanchez@inecol.mx,#{m}) &`
                    }

                    #OTROS
                    emails_otros.each do |eotro|
                        Thread.new  {               
                            `(sleep 140;cat #{path} | mail -a "Content-Type: text/html; charset=UTF-8" -s "Dictamen de Proyecto-#{@proyecto.persona.nom_espacio}-#{@proyecto.nombre[0..20]}" #{eotro}) &`
                         }
                    end 

                    #AREA PROYECTOS EXTERNOS
                    #Thread.new  {
                    #    `(sleep 15;cat #{path} | mail -a "Content-Type: text/html; charset=UTF-8" -s "Dictamen de Proyecto-#{@proyecto.persona.nom_espacio}-#{@proyecto.nombre[0..20]}" sara.sanchez@inecol.mx) &`
                    #}
                   
                    format.html { redirect_to dictamen_path(@dictamen) } 
            else
                    flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                    format.html { render :new, status: :bad_request }
            end
        end
  end

  def notificar
      @dictamen = Dictamen.find(params[:dictamen])
      @proyecto = Proyecto.find(@dictamen.proyecto_id)

      current_time = Time.now
      tiempo = (current_time.to_f * 1000).to_i
      file_nm = "email_temporal_#{tiempo.to_s}.txt"
      path = "log/#{file_nm}"

      File.open(path, 'w') do |file|
        file.write("<html><body style='font-size:15px;font-family: Arial, Helvetica, sans-serif;'>
                     #{@dictamen.txtdictamen}
                     <p><b>Enlace: <a href='https://sisproyectos.inecol.edu.mx/'>Ingresar al Sistema de Proyectos Externos</a></b>
                    </body></html>")
      end 

      Thread.new  {
        `(sleep 15;cat #{path} | mail -a "Content-Type: text/html; charset=UTF-8" -s "Dictamen de Proyecto-#{@proyecto.persona.nom_espacio}-#{@proyecto.nombre[0..20]}" sara.sanchez@inecol.mx,antonio.francisco@inecol.mx) &`
      }
  end

  private
  def dictamen_params
      params.require(:dictamen).permit(:proyecto_id, :tvalidacion_id, :numregistro, :txtdictamen, :otrose, docdictamenes:[])
  end

end
