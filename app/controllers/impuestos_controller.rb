class ImpuestosController < ApplicationController
  def index
  end

  def show
      @impuesto = Impuesto.find(params[:id].to_i)    
      @presupuesto = Presupuesto.find(params[:presupuesto_id].to_i) 
      @proyecto = Proyecto.find(params[:proyecto_id].to_i) 
      @moneda = @presupuesto.moneda
  end

  def edit
      
  end

  def update

  end

  def new
        
        @presupuesto = Presupuesto.find(params[:presupuesto_id].to_i) 
        @proyecto = Proyecto.find(params[:proyecto_id].to_i) 
        @moneda = @presupuesto.moneda

        if @proyecto.tpoverhead.nil?
             @impuesto_ant = Impuesto.find(1)
        else
             @impuesto_ant = Impuesto.find(@proyecto.tpoverhead)    
        end

        @impuesto = Impuesto.new

  end

  def create
      @presupuesto = Presupuesto.find(params[:presupuesto_id].to_i) 
      @proyecto = Proyecto.find(params[:proyecto_id].to_i) 

      @impuesto = Impuesto.new(impuesto_params)
      respond_to do |format|
          if @impuesto.save
                @proyecto.tpoverhead = @impuesto.id
                @proyecto.save

                @presupuesto.overhead = params[:overhead]
                @presupuesto.estimulo = params[:estimulo]
                @presupuesto.iva = params[:iva]
                @presupuesto.tgastos = params[:totalgastos]
                @presupuesto.tproyecto = params[:totalproyecto]
                @presupuesto.save(validate: false)
                puts @presupuesto.errors.full_messages
                format.html { redirect_to proyecto_presupuesto_impuesto_path(@proyecto.id, @presupuesto.id, @impuesto.id) }
          else    
                 flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                 format.html { render :new, status: :bad_request}
          end
      end    
  end

  private
  def impuesto_params
        params.require(:impuesto).permit(
            :porc_overhead,
            :porc_estimulo,
            :porc_iva,
            :clave
        )
  end 


end
