require 'util/email.rb'

class ValidacionesController < ApplicationController
  def index
      @proyecto = Proyecto.find(params[:idpy])
      @evaluadores = Evaluador.where(evalua:true)
  end

  def new
      @validacion = Validacion.new
      @proyecto = Proyecto.find(params[:idpy])
      @tvalidacion = params[:tval]
      @fecha_inicial =  Date.today
      @fecha_limite = lim_eval
  end

  def show
      @validacion = Validacion.find(params[:id])
      @proyecto = Proyecto.find(@validacion.proyecto_id)
  end

  def create
      @validacion = Validacion.new(validacion_params)
      @proyecto = Proyecto.find(params[:validacion][:proyecto_id])
      txt_mod = '' 

      if @proyecto.modificatorio == 'SI'
              txt_mod = 'Modificación de Proyecto' 
      else
              txt_mod = 'Proyecto para Evaluación'
      end

      respond_to do |format|
          if @validacion.save
                  enevento = Enevento.where(clave:'EVAL').first
                  if current_usuario.cuenta.rol.clave == 'EL'

                      Enlace.create(proyecto_id:@proyecto.id, enevento_id:enevento.id)
                      Solicitud.create(proyecto_id:@proyecto.id, fecha_sol:params[:fsol], fecha_lim:params[:flim], estado:'A')

                      #Util::Email.notificar(@proyecto.id, 'ENEVA')

                      emails = ['secretaria.academica@inecol.mx','secretaria.posgrado@inecol.mx','indra.morandin@inecol.mx', 'betsabe.ruiz@inecol.mx', 'sara.sanchez@inecol.mx']
                      espacios = [20,40,60,80,100]

                      current_time = Time.now
                      tiempo = (current_time.to_f * 1000).to_i
                      file_nm = "email_evaluadores_#{tiempo.to_s}.txt"
                      path = "log/#{file_nm}"
                  
                      File.open(path, 'w') do |file|
                                file.write("<html><body style='font-size:14px;font-family: Arial, Helvetica, sans-serif;'>
                                            #{@validacion.txtval}
                                            <p><b>Enlace: <a href='https://sisproyectos.inecol.edu.mx/'>Ingresar al Sistema de Proyectos Externos</a></b>
                                            </body></html>")
                      end 

                      i = 0
                      emails.each do |mail|
                            t = espacios[i] 
                            Thread.new  {
                                         `(sleep #{t.to_s};cat #{path} | mail -a "Content-Type: text/html; charset=UTF-8" -s "#{txt_mod}-#{@proyecto.persona.nom_espacio}-#{@proyecto.nombre[0..20]}" -a 'Reply-To:sara.sanchez@inecol.mx' #{mail}) &`
                                        }  
                            i = i+1  
                      end

                  end     

                  if current_usuario.cuenta.rol.clave == 'EL'
                        format.html { redirect_to validaciones_path(:idpy=>@proyecto.id) } 
                  end   
                  if current_usuario.cuenta.rol.clave == 'EVAL'
                        evalua_cont = Evaluador.where(estado:'A', evalua:true).count
                        aplicado_cont = Validacion.where(proyecto_id: @proyecto.id).includes(:evaluador).where('evaluador.estado':'A', 'evaluador.evalua':true).count

                        if aplicado_cont == evalua_cont
                              #Util::Email.notificar(@proyecto.id, 'VALCOM')
                        end
                        
                        format.html { redirect_to validacion_path(@validacion) } 
                  end   
            else
                  flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                  format.html { render :new, status: :bad_request }
          end
      end
  end

  private
  def validacion_params
      params.require(:validacion).permit(:proyecto_id, :evaluador_id, :tvalidacion_id, :txtval, :docficha, dcevaluaciones:[])
  end

  def lim_eval
      hoy = Date.today
      dias_base = 5
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

end