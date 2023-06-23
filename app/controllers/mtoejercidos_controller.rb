class MtoejercidosController < ApplicationController
  def index
       @proyecto = Proyecto.find(params[:proyecto_id])
  end

  def show
  end

  def new
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoejercido = Mtoejercido.new 
  end

  def edit
  end

  def update
  end

  def create
        m = '$'
        params[:mtoejercido][:monto] = params[:mtoejercido][:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
        @mtoejercido = Mtoejercido.new(mtoejercido_params)
        @proyecto = Proyecto.find(params[:proyecto_id])
        respond_to do |format|
            if @mtoejercido.save
                   format.html { redirect_to proyecto_mtoejercidos_path(@proyecto) }
            else
                    flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                    format.html { render :new, status: :bad_request }
            end
        end
  end

  private
  def mtoejercido_params
       params.require(:mtoejercido).permit(:fecha, :monto, :proyecto_id)
  end

end
