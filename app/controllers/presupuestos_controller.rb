class PresupuestosController < ApplicationController
  def index
  end

  def show
      @presupuesto = Presupuesto.find(params[:id]) 
      @proyecto = @presupuesto.proyecto
      @sum_caps = @presupuesto.solicitados.sum(:monto)
      @moneda = @presupuesto.moneda
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
      puts "##################"
      puts params[:id]
      p @presupuesto.to_json
      @proyecto = Proyecto.find(@presupuesto.proyecto_id)
      
  end

  def update
      @presupuesto = Presupuesto.find(params[:id])
      
      moneda = Moneda.find(params[:presupuesto][:moneda_id]) 
      m = moneda.currency

      params[:presupuesto][:costo] = params[:presupuesto][:costo].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:iva] = params[:presupuesto][:iva].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:tproyecto] = params[:presupuesto][:tproyecto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:overhead] = params[:presupuesto][:overhead].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:estimulo] = params[:presupuesto][:estimulo].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      params[:presupuesto][:tgastos] = params[:presupuesto][:tgastos].gsub(m,'').gsub(',','').gsub(/\s+/,'')
         
      params[:presupuesto][:solicitados_attributes].each do |i, v|
             params[:presupuesto][:solicitados_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      end


      @presupuesto.update(presupuesto_params)
      @proyecto = Proyecto.find(params[:presupuesto][:proyecto_id])
      respond_to do |format|
           if @presupuesto.save
                format.html { redirect_to presupuesto_path(@presupuesto) }
           else
                if !@presupuesto.errors.where(:base).blank?
                     flash.now[:montos] = @presupuesto.errors.where(:base).first.full_message
                else
                     flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                end  
                format.html { render :edit, status: :bad_request}
           end
      end
  end

  def create
   
   if !params[:tproyecto].present?
            @solicitado_p = 0.0
            if params[:presupuesto][:moneda_id].present?
                      moneda = Moneda.find(params[:presupuesto][:moneda_id]) 
                      m = moneda.currency
            else
                      m = ''
            end

            params[:presupuesto][:costo] = params[:presupuesto][:costo].gsub(m,'').gsub(',','').gsub(/\s+/,'')
            params[:presupuesto][:iva] = params[:presupuesto][:iva].gsub(m,'').gsub(',','').gsub(/\s+/,'')
            params[:presupuesto][:tproyecto] = params[:presupuesto][:tproyecto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
            params[:presupuesto][:overhead] = params[:presupuesto][:overhead].gsub(m,'').gsub(',','').gsub(/\s+/,'')
            params[:presupuesto][:estimulo] = params[:presupuesto][:estimulo].gsub(m,'').gsub(',','').gsub(/\s+/,'')
            params[:presupuesto][:tgastos] = params[:presupuesto][:tgastos].gsub(m,'').gsub(',','').gsub(/\s+/,'')
                
            params[:presupuesto][:solicitados_attributes].each do |i, v|
                    params[:presupuesto][:solicitados_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
                    v_mto = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
                    if !v_mto.nil?
                        @solicitado_p += v_mto.to_f
                    end
            end
            

            @presupuesto = Presupuesto.new(presupuesto_params)
            @proyecto = Proyecto.find(@presupuesto.proyecto_id)
            respond_to do |format|
                    if @presupuesto.save
                        session[:step] += 1
                        #format.html { redirect_to new_recurso_path } 
                        format.html { redirect_to @presupuesto } 
                    else
                            if @presupuesto.errors.where(:base).any?
                                flash.now[:montos] = @presupuesto.errors.where(:base).first.full_message
                            else
                                flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                            end  

                            items_caps = false
                            if  params[:presupuesto][:solicitados_attributes].present?
                                   params[:presupuesto][:solicitados_attributes].each do |i, v|
                                          if params[:presupuesto][:solicitados_attributes][i][:capitulo_id].nil?
                                                 items_caps = true
                                          end
                                   end
                            end        

                            if !items_caps
                                   @presupuesto.solicitados.build
                            end  
                            format.html { render :new, status: :bad_request }
                            
                            
                    end
            end
    else
        respond_to do |format|   
             session[:step] += 1
             @proyecto = Proyecto.find(params[:proyecto_id])
             m = Moneda.where(clave:'MXN').first
             @presupuesto = Presupuesto.create!(costo:0.0, tgastos:0.0, proyecto_id:@proyecto.id, moneda_id:m.id, solicitados_attributes:[capitulo_id:1,monto:0.0] )
             format.html { redirect_to new_recurso_path } 
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
