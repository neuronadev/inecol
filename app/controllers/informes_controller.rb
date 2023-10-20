class InformesController < ApplicationController
  def index
      @proyecto =  Proyecto.find(params[:proyecto_id])
      @informes = @proyecto.informes
  end

  def show
  end

  def new
      @proyecto =  Proyecto.find(params[:proyecto_id])
      @informe = Informe.new 
  end

  def create
      @informe = Informe.new(informe_params)
      @proyecto =  Proyecto.find(params[:proyecto_id])
      respond_to do |format|
            if @informe.save
                   format.html { redirect_to proyecto_informes_path(@proyecto) }
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
  def informe_params
       params.require(:informe).permit(:proyecto_id, :tinforme_id, :dinforme)
  end

end
