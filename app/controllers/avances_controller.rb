class AvancesController < ApplicationController
  def index
      @proyecto =  Proyecto.find(params[:proyecto_id])
      @avances = @proyecto.avances
  end

  def show
  end

  def new
      @proyecto =  Proyecto.find(params[:proyecto_id])
      @avance = Avance.new
  end

  def create
      @avance = Avance.new(avance_params)
      @proyecto =  Proyecto.find(params[:proyecto_id])
      respond_to do |format|
            if @avance.save
                   format.html { redirect_to proyecto_avances_path(@proyecto) }
            else
                    flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                    format.html { render :new, status: :bad_request }
            end
      end
  end

  def edit
  end

  def update
  end

  private
  def avance_params
       params.require(:avance).permit(:proyecto_id, :porcentaje, :fecha, :txtavance)
  end
end
