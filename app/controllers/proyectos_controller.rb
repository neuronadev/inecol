class ProyectosController < ApplicationController
  def index
  end

  def show
      @proyecto = Proyecto.find(params[:id])
  end

  def new
      session[:proyecto_id] = nil
      session[:step] = 0
      @proyecto = Proyecto.new
      @proyecto.instituciones.build
     
  end

  def create
      @proyecto = Proyecto.new(proyecto_params)
      respond_to do |format|
            if @proyecto.save
                   session[:proyecto_id] = @proyecto.id
                   Nav::stepInc
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
