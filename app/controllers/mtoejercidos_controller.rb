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

      @fecha_ini = nil
      @fecha_fin = nil

      @autorizado = true

      if !@proyecto.mtoautorizado.nil?
           @fecha_ini = @proyecto.mtoautorizado.finicio
           @fecha_fin = @proyecto.mtoautorizado.ftermino
      else
           @autorizado = false
      end
 
      if @proyecto.prorrogas.any?
          @fecha_fin = @proyecto.prorrogas.order(:created_at).last.fecha
      end

      
  end

  def edit
  end

  def update
  end

  def create
        @proyecto = Proyecto.find(params[:proyecto_id])
        @moneda = @proyecto.presupuesto.moneda
        m = @proyecto.presupuesto.moneda.currency

        @fecha_ini = nil
        @fecha_fin = nil
  
        if !@proyecto.mtoautorizado.nil?
             @fecha_ini = @proyecto.mtoautorizado.finicio
             @fecha_fin = @proyecto.mtoautorizado.ftermino
        end
   
        if @proyecto.prorrogas.any?
            @fecha_fin = @proyecto.prorrogas.order(:created_at).last.fecha
        end

        params[:mtoejercido][:monto] = params[:mtoejercido][:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
        @mtoejercido = Mtoejercido.new(mtoejercido_params)
        
        respond_to do |format|
            if @mtoejercido.save
                   format.html { redirect_to proyecto_mtoejercidos_path(@proyecto) }
            else
                    #flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                    if @mtoejercido.errors.where(:base).any?
                         flash.now[:monto] = @mtoejercido.errors.where(:base).first.full_message
                    elsif @mtoejercido.errors.where(:fecha).any?
                          flash.now[:fecha] = @mtoejercido.errors.where(:fecha).first.full_message 
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
