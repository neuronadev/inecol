class MtoconcurrentesController < ApplicationController
  def index
  end

  def show
       @proyecto = Proyecto.find(params[:proyecto_id])
       @mtoconcurrente = Mtoconcurrente.find(params[:id])
       @moneda = @proyecto.presupuesto.moneda
       
  end

  def new
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoconcurrente = Mtoconcurrente.new
      @moneda_sym = @proyecto.presupuesto.moneda.currency
  end

  def create
      @proyecto = Proyecto.find(params[:proyecto_id])
      m = @proyecto.presupuesto.moneda.currency

      params[:mtoconcurrente][:monto] = params[:mtoconcurrente][:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')

      @mtoconcurrente = Mtoconcurrente.new(mtoconcurrente_params)
      
      respond_to do |format|
          if @mtoconcurrente.save
                format.html { redirect_to proyecto_mtoconcurrente_path(@proyecto, @mtoconcurrente) }
          else
                  flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                  format.html { render :new, status: :bad_request }
          end
      end
  end

  def edit
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoconcurrente = Mtoconcurrente.find(params[:id])
      @moneda_sym = @proyecto.presupuesto.moneda.currency
  end

  def update
      @proyecto = Proyecto.find(params[:proyecto_id])
      m = @proyecto.presupuesto.moneda.currency
      params[:mtoconcurrente][:monto] = params[:mtoconcurrente][:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      @mtoconcurrente = Mtoconcurrente.find(params[:id])
      
      @mtoconcurrente.update(mtoconcurrente_params)
      respond_to do |format|
          if @mtoconcurrente.save
              format.html { redirect_to proyecto_mtoconcurrente_path(@proyecto, @mtoconcurrente) }
          else
              format.html { render :edit, status: :bad_request }
          end
      end
  end
  private
  def mtoconcurrente_params
      params.require(:mtoconcurrente).permit(:fecha, :monto, :proyecto_id)
  end
end
