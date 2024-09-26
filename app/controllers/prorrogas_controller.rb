class ProrrogasController < ApplicationController
  def index
  end

  def show
  end

  def new
      @proyecto = Proyecto.find(params[:proyecto_id])
      @prorroga = Prorroga.new
  end

  def create
       @proyecto = Proyecto.find(params[:proyecto_id])
       @prorroga = Prorroga.new(prorroga_params)
       respond_to do |format|
          if @prorroga.save
              format.html { redirect_to preview_proyecto_mtoautorizado_path(@proyecto, @proyecto.mtoautorizado) }
          else 
              flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores.'
              puts "--------------------------"
              puts flash.to_json
              format.html { render :new, status: :bad_request }
          end  
       end    
  end

  def edit
  end

  def update
  end

  private 
  def prorroga_params
      params.require(:prorroga).permit(:proyecto_id, :fecha, :txtobs)
  end

end
