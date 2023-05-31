class RecursosController < ApplicationController
  def index
  end

  def show
      @recurso = Recurso.find(params[:id])
      @proyecto = @recurso.proyecto

      #@ffis = @recurso.aportados.includes(:fondo).where('fondos.clave':'FF').first
      #@aes = @recurso.aportados.includes(:fondo).where('fondos.clave':'AE').first
      #@fcon = @recurso.aportados.includes(:fondo).where('fondos.clave':'FC').first

      @tot_ffis = @recurso.fiscales.sum(:monto)
      @tot_aes = @recurso.especies.sum(:monto)
      @tot_fcon = @recurso.concurrentes.sum(:monto)

  end

  def new
      @proyecto = Proyecto.find(session[:proyecto_id])
      @recurso = Recurso.new
      #@aportados = @recurso.aportados.build
      @recurso.fiscales.build
      @recurso.especies.build
      @recurso.concurrentes.build

      #@ff_id = Fondo.where(clave:'FF').first.id
      #@ae_id = Fondo.where(clave:'AE').first.id
      #@fc_id = Fondo.where(clave:'FC').first.id
      
  end

  def edit
      @recurso = Recurso.find(params[:id]) 
  end

  def update
    m = '$'
    params[:recurso][:fiscales_attributes].each do |i, v|
        params[:recurso][:fiscales_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
    end

    params[:recurso][:especies_attributes].each do |i, v|
      params[:recurso][:especies_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
    end
    params[:recurso][:concurrentes_attributes].each do |i, v|
        params[:recurso][:concurrentes_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
    end

      @recurso = Recurso.find(params[:id]) 
      @recurso.update(recurso_params)
      respond_to do |format|
           if @recurso.save
               format.html { redirect_to recurso_path(@recurso) }
           else
               p '---------------------------Errors------------------'
               @recurso.errors
               flash.now[:notice] = 'La infomación esta incompleta, favor de revisar los errores'
               format.html { render :edit, status: :bad_request }
           end
      end
  end

  def create
      m = '$'
      params[:recurso][:fiscales_attributes].each do |i, v|
          params[:recurso][:fiscales_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      end

      params[:recurso][:especies_attributes].each do |i, v|
        params[:recurso][:especies_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      end
      params[:recurso][:concurrentes_attributes].each do |i, v|
          params[:recurso][:concurrentes_attributes][i][:monto] = v[:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      end

      @recurso = Recurso.new(recurso_params)
      @proyecto = Proyecto.find(@recurso.proyecto_id)
      respond_to do |format|
          if @recurso.save
              session[:step] += 1
              format.html { redirect_to new_meta_path }
          else
               p '---------------------------Errors------------------'
               p @recurso.errors
              flash.now[:notice] = 'La infomación esta incompleta, favor de revisar los errores'
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
