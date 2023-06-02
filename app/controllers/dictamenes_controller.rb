class DictamenesController < ApplicationController
  def index
  end

  def new
      @dictamen = Dictamen.new
      @proyecto = Proyecto.find(params[:idpy])
  end

  def show
      @dictamen = Dictamen.find(params[:id])
      @proyecto = Proyecto.find(@dictamen.proyecto_id)
  end

  def create
      @dictamen = Dictamen.new(dictamen_params)
      @proyecto = Proyecto.find(params[:dictamen][:proyecto_id])
      enevento = Enevento.where(clave:'DICT').first

      respond_to do |format|
            if @dictamen.save
                   Enlace.create!(proyecto_id:@proyecto.id, enevento_id:enevento.id)
                   format.html { redirect_to resumen_vistas_path(:id=>@proyecto.id) } 
            else
                   flash.now[:notice] = 'La infomación esta incompleta, favor de revisar los errores'
                   format.html { render :new, status: :bad_request }
            end
      end
  end

  private
  def dictamen_params
      params.require(:dictamen).permit(:proyecto_id, :numregistro, :txtdictamen, :docdictamen)
  end
end
