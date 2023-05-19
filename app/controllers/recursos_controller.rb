class RecursosController < ApplicationController
  def index
  end

  def show
      @recurso = Recurso.find(params[:id])

      @ffis = @recurso.aportados.includes(:fondo).where('fondos.clave':'FF').first
      @aes = @recurso.aportados.includes(:fondo).where('fondos.clave':'AE').first
      @fcon = @recurso.aportados.includes(:fondo).where('fondos.clave':'FC').first

      @tot_ffis = @recurso.aportados.includes(:apmontos).includes(:fondo).where('fondos.clave':'FF').sum('apmontos.monto')
      @tot_aes = @recurso.aportados.includes(:apmontos).includes(:fondo).where('fondos.clave':'AE').sum('apmontos.monto')
      @tot_fcon = @recurso.aportados.includes(:apmontos).includes(:fondo).where('fondos.clave':'FC').sum('apmontos.monto')

  end

  def new
      @proyecto = Proyecto.find(session[:proyecto_id]) 
      @recurso = Recurso.new
      @aportados = @recurso.aportados.build
      @aportados.apmontos.build
      
  end

  def edit
      @recurso = Recurso.find(params[:id]) 
  end

  def update
      @recurso = Recurso.find(params[:id]) 
      @recurso.update(recurso_params)
      respond_to do |format|
           if @recurso.save
               format.html { redirect_to recurso_path(@recurso) }
           else
               format.html { render :edit, status: :bad_request }
           end
      end
  end

  def create
      @recurso = Recurso.new(recurso_params)
      respond_to do |format|
          if @recurso.save
              session[:step] += 1
              format.html { redirect_to new_meta_path }       
          else
              format.html { render :new, status: :bad_request }
          end
      end    
  end

  private
  def recurso_params
      params.require(:recurso).permit(
                                        :proyecto_id,
                                        aportados_attributes:[:id, :fondo_id, :_destroy, apmontos_attributes:[:id, :capitulo_id, :monto, :_destroy]]
                                        
                                      )
  end
end
