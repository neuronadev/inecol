class RecursosController < ApplicationController
  def index
  end

  def show
      @recurso = Recurso.find(params[:id])
  end

  def new
      @proyecto = Proyecto.find(session[:proyecto_id]) 
      @recurso = Recurso.new
      @recurso.aportados.build
  end

  def edit
  end

  def update
  end

  def create
      @recurso = Recurso.new(recurso_params)
      respond_to do |format|
          if @recurso.save
              Nav::stepInc
              Nav::onRecurso
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
                                        aportados_attributes:[:id, :fondo_id, apmontos_attributes:[:id, :capitulo_id, :monto, :_destroy]]
                                      )
  end
end
