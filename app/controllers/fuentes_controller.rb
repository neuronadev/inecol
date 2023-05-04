class FuentesController < ApplicationController
    
  def index
  end

  def show
   
  end

  def new
    @proyecto = Proyecto.find(session[:proyecto_id]) 
    @fuente = Fuente.new
  end

  def edit
  end

  def update
  end

  def create
      @fuente = Fuente.new(fuente_params)
      respond_to do |format|
          if @fuente.save
                format.html { redirect_to new_participante_path } 
          else
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

