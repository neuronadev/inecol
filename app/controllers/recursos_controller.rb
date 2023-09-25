class RecursosController < ApplicationController
  def index
  end

  def show
      @recurso = Recurso.find(params[:id])
      @proyecto = @recurso.proyecto
      @moneda = @proyecto.presupuesto.moneda
      #@ffis = @recurso.aportados.includes(:fondo).where('fondos.clave':'FF').first
      #@aes = @recurso.aportados.includes(:fondo).where('fondos.clave':'AE').first
      #@fcon = @recurso.aportados.includes(:fondo).where('fondos.clave':'FC').first

      @tot_ffis = @recurso.fiscales.sum(:monto)
      @tot_aes = @recurso.especies.sum(:monto)
      @tot_fcon = @recurso.concurrentes.sum(:monto)

  end

  def omitir
      @proyecto = Proyecto.find(params[:idpy])
      @recurso = Recurso.create!(proyecto_id:@proyecto.id, omitir:true)
      session[:step] += 1
      redirect_to new_meta_path
  end

  def new
      @proyecto = Proyecto.find(session[:proyecto_id])
      @recurso = Recurso.new
      #@aportados = @recurso.aportados.build
      @recurso.fiscales.build
      @recurso.especies.build
      @recurso.concurrentes.build

      @moneda = @proyecto.presupuesto.moneda
      
      @t_ffiscales = 0.0
      @t_especie = 0.0
      @t_concur = 0.0
      

      
  end

  def edit
      @recurso = Recurso.find(params[:id]) 
      @proyecto = Proyecto.find(@recurso.proyecto_id)
      @moneda = @proyecto.presupuesto.moneda

      @t_ffiscales = 0.0
      @t_especie = 0.0
      @t_concur = 0.0
      if !@recurso.omitir
          if @recurso.fiscales.any?
               @t_ffiscales = @recurso.fiscales.sum(:monto)
          end
          if @recurso.especies.any?
               @t_especie = @recurso.especies.sum(:monto)
          end
          if @recurso.concurrentes.any?
              @t_concur = @recurso.concurrentes.sum(:monto)
       end
      end    
  end

  def update
    @recurso = Recurso.find(params[:id]) 
    @proyecto = Proyecto.find(@recurso.proyecto_id)
    
    moneda = Moneda.find( @proyecto.presupuesto.moneda.id ) 
    m = moneda.currency

    if params[:recurso].has_key?("fiscales_attributes".to_sym)
        params[:recurso][:fiscales_attributes].each do |i, v|
            params[:recurso][:fiscales_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
        end
    end
    if params[:recurso].has_key?("especies_attributes".to_sym)
            params[:recurso][:especies_attributes].each do |i, v|
                params[:recurso][:especies_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
            end
    end      
    if params[:recurso].has_key?("concurrentes_attributes".to_sym)
            params[:recurso][:concurrentes_attributes].each do |i, v|
                params[:recurso][:concurrentes_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
            end
    end     

      
      @recurso.update(recurso_params)
      respond_to do |format|
           if @recurso.save
               format.html { redirect_to recurso_path(@recurso) }
           else
               p '---------------------------Errors------------------'
               @recurso.errors
               flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
               format.html { render :edit, status: :bad_request }
           end
      end
  end

  def create

      @proyecto = Proyecto.find(params[:recurso][:proyecto_id])
      moneda = Moneda.find( @proyecto.presupuesto.moneda.id ) 
      m = moneda.currency

      if params[:recurso].has_key?("fiscales_attributes".to_sym)
            params[:recurso][:fiscales_attributes].each do |i, v|
                params[:recurso][:fiscales_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
            end
      end
      if params[:recurso].has_key?("especies_attributes".to_sym)
            params[:recurso][:especies_attributes].each do |i, v|
                params[:recurso][:especies_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
            end
      end      
      if params[:recurso].has_key?("concurrentes_attributes".to_sym)
            params[:recurso][:concurrentes_attributes].each do |i, v|
                params[:recurso][:concurrentes_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
            end
      end     

      @recurso = Recurso.new(recurso_params)
      @proyecto = Proyecto.find(@recurso.proyecto_id)
      respond_to do |format|
          if @recurso.save
              session[:step] += 1
              #format.html { redirect_to new_meta_path }
              format.html { redirect_to @recurso }
          else
               p '---------------------------Errors------------------'
               p @recurso.errors
              flash.now[:error] = 'La información esta incompleta, favor de revisar los errores'
              format.html { render :new, status: :bad_request }
          end
      end    
  end

  private
  def recurso_params
      params.require(:recurso).permit(
                                        :proyecto_id, :doficio,
                                        fiscales_attributes:[:id, :capitulo_id, :monto, :_destroy],
                                        especies_attributes:[:id, :capitulo_id, :monto, :_destroy],
                                        concurrentes_attributes:[:id, :capitulo_id, :monto, :_destroy]

                                     )
  end
end
