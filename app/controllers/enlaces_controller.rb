class EnlacesController < ApplicationController
  def index
  end

  def new
    @enlace = Enlace.new
    @proyecto = Proyecto.find(params[:idpy])
    @enevento = Enevento.where(clave:params[:tipo]).first
    @tipo = params[:tipo]
  end

  def create
      @enlace = Enlace.new(enlace_params)
      @proyecto = Proyecto.find(params[:enlace][:proyecto_id])
      @enevento = Enevento.find(params[:enlace][:enevento_id])
      @tipo = @enevento.clave
      respond_to do |format|
            if @enlace.save
                   format.html { redirect_to resumen_vistas_path(:id=>@proyecto.id) } 
            else
                   flash.now[:notice] = 'La infomación esta incompleta, favor de revisar los errores'
                   format.html { render :new, status: :bad_request }
            end
      end
  end

  def mensaje
      @proyecto = Proyecto.find(params[:idpy])
  end

  private
  def enlace_params
      params.require(:enlace).permit(:proyecto_id, :enevento_id, :txtcoment, :estado)
  end

end
