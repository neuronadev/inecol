class PresupuestosController < ApplicationController
  def index
  end

  def show
      @presupuesto = Presupuesto.find(params[:id]) 
      @sum_caps = @presupuesto.solicitados.sum(:monto)
  end

  def new
      @proyecto = Proyecto.find(session[:proyecto_id]) 
      @presupuesto = Presupuesto.new
      @presupuesto.solicitados.build

      @py_clasif = @proyecto.clasificacion.clave
      @py_ovh = @proyecto.overhead

      if @py_clasif == 'SNREC'
            #redirect_to new_recurso_path
      end

  end

  def edit
      @presupuesto = Presupuesto.find(params[:id])  
  end

  def update
      @presupuesto = Presupuesto.find(params[:id])
      @presupuesto.update(presupuesto_params)
      respond_to do |format|
           if @presupuesto.save
               format.html { redirect_to presupuesto_path(@presupuesto) }
           else
               format.html { render :edit, status: :bad_request }
           end
      end
  end

  def create
      @presupuesto = Presupuesto.new(presupuesto_params)
      respond_to do |format|
            if @presupuesto.save
                   session[:step] += 1
                   format.html { redirect_to new_recurso_path } 
            else
                   format.html { render :new, status: :bad_request }
            end
      end
  end

  def pyclasifica
      @proyecto = Proyecto.find(params[:proyecto_id])
      py_clasif = @proyecto.clasificacion.clave
      py_ovh = @proyecto.overhead
      
      data = {clasifica:py_clasif, ovh:@proyecto.overhead}
      
      respond_to do |format|
            format.json { render json:data.to_json }
      end
  end

  private
   def presupuesto_params
       params.require(:presupuesto).permit(
                                             :proyecto_id,
                                             :moneda_id,
                                             :costo,
                                             :iva,
                                             :tproyecto,
                                             :overhead,
                                             :estimulo,
                                             :tgastos,
                                             solicitados_attributes:[:id, :capitulo_id, :monto, :_destroy]
                                           )
   end

end
