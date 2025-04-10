require 'util/email.rb'
require 'util/dato.rb'

class DictamenesController < ApplicationController

  def index
  end

  def new
      @dictamen = Dictamen.new
      @proyecto = Proyecto.find(params[:idpy])
      @fecha_inicial =  Date.today
      @fecha_limite = lim_eval

      if @proyecto.modificatorio == 'SI'
           @numreg =  Util::Dato.numregmod @proyecto.id
      else
           @numreg = nil
      end  

  end

  def show
      @dictamen = Dictamen.find(params[:id])
      @proyecto = Proyecto.find(@dictamen.proyecto_id)

      if @proyecto.modificatorio == 'SI'
          @numreg =  Util::Dato.numregmod @proyecto.id
      else
          @numreg = nil
      end  

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
                    Solfirma.create(proyecto_id:@proyecto.id, fecha_dict:params[:fsol], fecha_lim:params[:flim], estado:'A')

                    Util::Email.notificar(@proyecto.id, 'ENEVD') 
                    sleep 8
                    Util::Email.notificar(@proyecto.id, 'ENRPD') 
                    
                    #if !@dictamen.otrose.blank?
                    #       Util::Email.notificar(@proyecto.id, 'OTROSE') 
                    #end

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

  def lim_eval
    hoy = Date.today
    dias_base = 3
    dias_tmp = dias_base
    limit_calc = rango(hoy, dias_tmp)
    while limit_calc <= dias_base
         dias_tmp += 1
         limit_calc = rango(hoy, dias_tmp)
    end
    return hoy + dias_tmp
  end

  def rango(fini, dias)
    ( (fini)..(fini + dias) ).select {|d| (1..5).include?(d.wday) }.size
  end

  private
  def dictamen_params
      params.require(:dictamen).permit(:proyecto_id, :tvalidacion_id, :numregistro, :txtdictamen, :otrose, docdictamenes:[])
  end

end
