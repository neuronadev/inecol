class FuentesController < ApplicationController
    
  def index
  end

  def show
     @fuente = Fuente.find(params[:id])
     @proyecto = @fuente.proyecto
  end

  def new
    @proyecto = Proyecto.find(session[:proyecto_id]) 
    @fuente = Fuente.new
  end

  def edit
      @fuente = Fuente.find(params[:id])
  end

  def update
      @fuente = Fuente.find(params[:id]) 
      @fuente.update(fuente_params)
      respond_to do |format|
           if @fuente.save
               format.html { redirect_to fuente_path(@fuente) }
           else
               format.html { render :edit, status: :bad_request }
           end
      end
  end

  def create
      @fuente = Fuente.new(fuente_params)
      @proyecto = Proyecto.find(@fuente.proyecto_id)
      respond_to do |format|
          if @fuente.save
                session[:step] += 1
                format.html { redirect_to new_participante_path } 
          else
                flash.now[:notice] = 'La infomación esta incompleta, favor de revisar los errores'
                format.html { render :new, status: :bad_request }
          end
      end
  end

  def lugar
      @id_naciona = params[:idnac]
      @nacionalidad = Nacionalidad.find(@id_naciona.to_i)
      @ops_lugares = Lugar.where(tiponac:@nacionalidad.clave)
      respond_to do |format|
          format.json { render json:@ops_lugares.to_json }
      end 
  end

  private
  def fuente_params
      params.require(:fuente).permit(:nomfuente, :nacionalidad_id, :lugar_id, :proyecto_id, :nomcontacto, :emailcontacto)
  end


end

