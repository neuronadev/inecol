class ProyectosController < ApplicationController
  def index
      @proyectos = Proyecto.where(persona_id:current_usuario.cuenta.persona.id)
  end

  def show
      @proyecto = Proyecto.find(params[:id])
      
  end

  def new
      session[:proyecto_id] = nil
      session[:step] = 0
      @proyecto = Proyecto.new
      @proyecto.instituciones.build
      @proyecto.build_mconvocatoria
      @proyecto.protocolos.build
      @proyecto.convenios.build
     
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
 
 

  private
  def proyecto_params
      params.require(:proyecto).permit(:nombre, 
                                       :clasificacion_id,
                                       :overhead,
                                       :medio_id,
                                       :linea_id,
                                       :periodo,
                                       :tfconoc,
                                       :interinst,
                                       :persona_id,
                                       mconvocatoria_attributes:[:id, :nomconvocatoria, :link, :dconvocatoria, :_destroy],
                                       instituciones_attributes:[:id, :nominstitucion, :_destroy],
                                       protocolos_attributes:[:id, :dprotocolo, :_destroy],
                                       convenios_attributes:[:id, :dconvenio, :_destroy]
                                      
                                    )
  end

end
