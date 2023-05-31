class ProyectosController < ApplicationController
  layout :select_layout

  def index
      @total_notifica_rp = 0

      if current_usuario.cuenta.rol.clave == 'EL'
             @proyectos = Proyecto.includes(etapas: :tevento).where('teventos.clave':'REV')
      elsif current_usuario.cuenta.rol.clave == 'CAP'
             @proyectos = Proyecto.where(persona_id:current_usuario.cuenta.persona.id)
             @total_notifica_rp = Proyecto.where(persona_id:current_usuario.cuenta.persona.id).includes(enlaces: :enevento).where('enlaces.estado':'A').where('eneventos.clave':'CORR').count
      else
             @proyectos = Proyecto.includes(validaciones: :tvalidacion).where('tvalidaciones.clave':'SOLV')           
      end


  end

  def show
      @proyecto = Proyecto.find(params[:id])
       respond_to do |format|
            format.html
            format.pdf do
                render pdf: "Invoice No. #{@proyecto.id}",
                page_size: 'A4',
                template: "proyectos/show",
                layout: "pdf",
                orientation: "Portrait",
                lowquality: false,
                encoding: 'UTF-8',
                zoom: 1,
                dpi: 75
            end
        end
  end

  def new
      session[:proyecto_id] = nil
      session[:step] = 0
      @proyecto = Proyecto.new
      @proyecto.instituciones.build
      @proyecto.build_mconvocatoria
      #@proyecto.build_protocolo
      #@proyecto.build_convenio
     
  end

  def create
      @proyecto = Proyecto.new(proyecto_params)
      respond_to do |format|
            if @proyecto.save
                   tevento = Tevento.where(clave:'CAP').first
                   Etapa.create!(proyecto_id:@proyecto.id, tevento_id:tevento.id)
                   session[:proyecto_id] = @proyecto.id
                   session[:step] = 1
                   format.html { redirect_to new_fuente_path } 
            else
                    flash.now[:notice] = 'La infomación esta incompleta, favor de revisar los errores'
                    format.html { render :new, status: :bad_request }
            end
      end
  end

  def edit
      @proyecto = Proyecto.find(params[:id])
      
  end

  def update
      @proyecto = Proyecto.find(params[:id]) 
      @proyecto.update(proyecto_params)
      respond_to do |format|
           if @proyecto.save
               format.html { redirect_to proyecto_path(@proyecto) }
           else
               format.html { render :edit, status: :bad_request }
           end
      end

  end

  def institucion
      @idx = (Time.now.to_f*1000.0).to_i
      respond_to do |format|
             format.html { render partial: 'fields_institucion'}
      end 
  end
  def tipomedio
      medio = Medio.find(params[:medio_id])
      data = {clave:medio.clave}
      respond_to do |format|
          format.json { render json:data.to_json }
      end
  end

  def tipoclasifica
      clasifica = Clasificacion.find(params[:clasifica_id])
      data = { clave:clasifica.clave, ovh:clasifica.ovh }
      respond_to do |format|
        format.json { render json:data.to_json }
      end
  end
  def medclave
       medio = Medio.where(clave:params[:clave_medio]).first
       data = {medio_id:medio.id}
       respond_to do |format|
        format.json { render json:data.to_json }
      end
  end

  def enviar
       proyecto = Proyecto.find(params[:id])
       evento = Tevento.where(clave:'REV').first
       Etapa.create!(proyecto_id:proyecto.id, tevento_id:evento.id)

       enevento = Enevento.where(clave:'NVO').first
       Enlace.create!(proyecto_id:proyecto.id, enevento_id:enevento.id)

       respond_to do |format|
           format.json { render json:@proyecto.to_json }
      end
  end
 
  private
  def proyecto_params
      params.require(:proyecto).permit(:nombre, 
                                       :objetivo,
                                       :clasificacion_id,
                                       :overhead,
                                       :medio_id,
                                       :linea_id,
                                       :periodo,
                                       :tfconoc,
                                       :interinst,
                                       :persona_id,
                                       :docprotocolo,
                                       docconvenios: [],
                                       mconvocatoria_attributes:[:id, :nomconvocatoria, :link, :dconvocatoria, :_destroy],
                                       instituciones_attributes:[:id, :nominstitucion, :_destroy]
                                       #protocolo_attributes:[:id, :dprotocolo, :activo],
                                       #convenio_attributes:[:id, :dconvenio, :activo]
                                      
                                    )
  end
 
  protected 
     def select_layout
        
        if !current_usuario.nil?
             if current_usuario.cuenta.rol.clave == 'EL'
                   return 'enlaces' 
             elsif current_usuario.cuenta.rol.clave == 'EVAL'
                   return 'validaciones'
             else
                   return 'proyectos'
             end
                
        end

    end        

end
