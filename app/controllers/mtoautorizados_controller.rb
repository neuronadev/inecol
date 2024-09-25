class MtoautorizadosController < ApplicationController
  def index
    @proyecto = Proyecto.find(params[:proyecto_id])
  end

  def show
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoautorizado = Mtoautorizado.find(params[:id])
      @moneda = @proyecto.presupuesto.moneda
  end

  def preview
      @proyecto = Proyecto.find(params[:proyecto_id])
      #@mtoautorizado = Mtoautorizado.find(params[:id])
      #@moneda = @proyecto.presupuesto.moneda
  end

  def new
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoautorizado = Mtoautorizado.new
      @moneda_sym = @proyecto.presupuesto.moneda.currency
  end

  def edit
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoautorizado = Mtoautorizado.find(params[:id])
      @moneda_sym = @proyecto.presupuesto.moneda.currency
  end

  def update
      @proyecto = Proyecto.find(params[:proyecto_id])
      m = @proyecto.presupuesto.moneda.currency
      
      params[:mtoautorizado][:monto] = params[:mtoautorizado][:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      @mtoautorizado = Mtoautorizado.find(params[:id])
      
      @mtoautorizado.update(mtoautorizado_params)
      respond_to do |format|
           if @mtoautorizado.save
               format.html { redirect_to proyecto_mtoautorizado_path(@proyecto, @mtoautorizado) }
           else
               format.html { render :edit, status: :bad_request }
           end
      end
  end

  def create
        @proyecto = Proyecto.find(params[:proyecto_id])
        m = @proyecto.presupuesto.moneda.currency
        
        params[:mtoautorizado][:monto] = params[:mtoautorizado][:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
        @mtoautorizado = Mtoautorizado.new(mtoautorizado_params)
        
        respond_to do |format|
            if @mtoautorizado.save
                   #format.html { redirect_to proyecto_mtoautorizado_path(@proyecto, @mtoautorizado) }
                   format.html { redirect_to proyecto_mtoautorizados_path(@proyecto) }
            else
                    flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                    format.html { render :new, status: :bad_request }
            end
        end
  end

  private
  def mtoautorizado_params
      params.require(:mtoautorizado).permit(:finicio, :ftermino, :monto, :proyecto_id, :tipo)
  end

end