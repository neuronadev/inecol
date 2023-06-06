class PresupuestosController < ApplicationController
  def index
  end

  def show
      @presupuesto = Presupuesto.find(params[:id]) 
      @proyecto = @presupuesto.proyecto
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
      m = '$'
      params[:presupuesto][:costo] = params[:presupuesto][:costo].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:iva] = params[:presupuesto][:iva].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:tproyecto] = params[:presupuesto][:tproyecto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:overhead] = params[:presupuesto][:overhead].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:estimulo] = params[:presupuesto][:estimulo].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:tgastos] = params[:presupuesto][:tgastos].gsub(m,'').gsub(',','').gsub(/\s+/,'')
         
      params[:presupuesto][:solicitados_attributes].each do |i, v|
             params[:presupuesto][:solicitados_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      end

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
      #m = Tipomoneda.find(params[:tipomoneda_id].to_i)
      m = '$'
      params[:presupuesto][:costo] = params[:presupuesto][:costo].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:iva] = params[:presupuesto][:iva].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:tproyecto] = params[:presupuesto][:tproyecto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:overhead] = params[:presupuesto][:overhead].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:estimulo] = params[:presupuesto][:estimulo].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:tgastos] = params[:presupuesto][:tgastos].gsub(m,'').gsub(',','').gsub(/\s+/,'')
         
      params[:presupuesto][:solicitados_attributes].each do |i, v|
             params[:presupuesto][:solicitados_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      end
     

      @presupuesto = Presupuesto.new(presupuesto_params)
      @proyecto = Proyecto.find(@presupuesto.proyecto_id)
      respond_to do |format|
            if @presupuesto.save
                   session[:step] += 1
                   format.html { redirect_to new_recurso_path } 
            else
                   flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
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
