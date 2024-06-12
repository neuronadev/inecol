class MtoejercidosController < ApplicationController
  def index
       @proyecto = Proyecto.find(params[:proyecto_id])
       @moneda = @proyecto.presupuesto.moneda
       
  end

  def show
  end

  def preview
    @proyecto = Proyecto.find(params[:proyecto_id])
    @moneda = @proyecto.presupuesto.moneda
  end

  def new
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoejercido = Mtoejercido.new 
      @moneda_sym = @proyecto.presupuesto.moneda.currency
      @moneda = @proyecto.presupuesto.moneda
  end

  def edit
  end

  def update
  end

  def create
        @proyecto = Proyecto.find(params[:proyecto_id])
        @moneda = @proyecto.presupuesto.moneda
        m = @proyecto.presupuesto.moneda.currency

        params[:mtoejercido][:monto] = params[:mtoejercido][:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
        @mtoejercido = Mtoejercido.new(mtoejercido_params)
        
        respond_to do |format|
            if @mtoejercido.save
                   format.html { redirect_to proyecto_mtoejercidos_path(@proyecto) }
            else
                    #flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                    if @mtoejercido.errors.where(:base).any?
                         flash.now[:monto] = @mtoejercido.errors.where(:base).first.full_message
                    else
                         flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                    end  
                    format.html { render :new, status: :bad_request }
            end
        end
  end

  private
  def mtoejercido_params
       params.require(:mtoejercido).permit(:fecha, :monto, :proyecto_id)
  end

end
