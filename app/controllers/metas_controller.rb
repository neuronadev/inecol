class MetasController < ApplicationController
  def index
  end

  def show
      @meta = Meta.find(params[:id]) 
      @proyecto = @meta.proyecto
  end

  def new
      @proyecto = Proyecto.find(session[:proyecto_id]) 
      @meta = Meta.new
  end

  def edit
      @meta = Meta.find(params[:id]) 
  end

  def update
      @meta = Meta.find(params[:id]) 
      @meta.update(meta_params)
      respond_to do |format|
           if @meta.save
               format.html { redirect_to meta_path(@meta) }
           else
               format.html { render :edit, status: :bad_request }
           end
      end 
  end

  def create
      @meta = Meta.new(meta_params)
      respond_to do |format|
          if @meta.save
               #session[:step] += 1
               session[:step] += 1
               #format.html { redirect_to resumen_vistas_path(:id=>@meta.proyecto_id) }
               format.html { redirect_to @meta }
          else
                @proyecto = Proyecto.find(session[:proyecto_id]) 
               format.html { render :new, status: :bad_request }
          end
      end 
  end

  private
   def meta_params
       params.require(:meta).permit(:proyecto_id, :esperado, :impacto, :comentario)
   end

end
