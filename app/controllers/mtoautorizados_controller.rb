class MtoautorizadosController < ApplicationController
  def index
      
  end

  def show
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoautorizado = Mtoautorizado.find(params[:id])
  end

  def new
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoautorizado = Mtoautorizado.new
  end

  def edit
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoautorizado = Mtoautorizado.find(params[:id])
  end

  def update
      m = '$'
      params[:mtoautorizado][:monto] = params[:mtoautorizado][:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
      @mtoautorizado = Mtoautorizado.find(params[:id])
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoautorizado.update(mtoautorizado_params)
      respond_to do |format|
           if @mtoautorizado.save
               format.html { redirect_to proyecto_mtoautorizado_path(@proyecto, @mtoautorizado) }
           else
               format.html { render :edit, status: :bad_request }
           end
      end
  end

  def create
        m = '$'
        params[:mtoautorizado][:monto] = params[:mtoautorizado][:monto].gsub(m,'').gsub(',','').gsub(/\s+/,'')
        @mtoautorizado = Mtoautorizado.new(mtoautorizado_params)
        @proyecto = Proyecto.find(params[:proyecto_id])
        respond_to do |format|
            if @mtoautorizado.save
                   format.html { redirect_to proyecto_mtoautorizado_path(@proyecto, @mtoautorizado) }
            else
                    flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                    format.html { render :new, status: :bad_request }
            end
        end
  end

  private
  def mtoautorizado_params
      params.require(:mtoautorizado).permit(:finicio, :ftermino, :monto, :proyecto_id)
  end

end