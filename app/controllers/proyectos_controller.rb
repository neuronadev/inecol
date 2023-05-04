class ProyectosController < ApplicationController
  def index
  end

  def show
  end

  def new
      @proyecto = Proyecto.new
      @proyecto.instituciones.build
  end

  def create
      @proyecto = Proyecto.new(proyecto_params)
      respond_to do |format|
            if @proyecto.save
                   session[:proyecto_id] = @proyecto.id
                   format.html { redirect_to new_fuente_path } 
            else
                   format.html { render :new, status: :bad_request }
            end
      end
  end

  def edit
  end

  def update
  end

  def institucion
      @idx = (Time.now.to_f*1000.0).to_i
      respond_to do |format|
             format.html { render partial: 'fields_institucion'}
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
                                       instituciones_attributes:[:id, :nominstitucion]  )
  end

end
