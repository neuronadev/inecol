class EnlacesController < ApplicationController
  def index
  end

  def show
      @enlace = Enlace.find(params[:id])
  end

  def new
    @enlace = Enlace.new
    @proyecto = Proyecto.find(params[:idpy])
    @enevento = Enevento.where(clave:params[:tipo]).first
    @tipo = params[:tipo]
  end

  def create
      @enlace = Enlace.new(enlace_params)
      @proyecto = Proyecto.find(params[:enlace][:proyecto_id])
      @enevento = Enevento.find(params[:enlace][:enevento_id])
      @tipo = @enevento.clave

      if @proyecto.enlaces.last.enevento.clave == 'PROC'
            enlace_last = Enlace.find(@proyecto.enlaces.last.id)
            enlace_last.estado = 'C'
            enlace_last.save
      end

      respond_to do |format|
            if @enlace.save
                   #format.html { redirect_to resumen_vistas_path(:id=>@proyecto.id) } 
                   message  = ResponsableMailer.with(p:@proyecto, e:@enlace).notificar_corregir
                   message.deliver_later
                   format.html { redirect_to enlace_path(@enlace) }
            else
                   flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                   format.html { render :new, status: :bad_request }
            end
      end
  end

  def mensaje
      @proyecto = Proyecto.find(params[:idpy])
  end

  def atendido
      enlace = Enlace.find(params[:enlace_id])

      #########################################################################
      enlace_py = enlace.proyecto_id
      enevento = Enevento.where(clave:'SOLA').first

      enlace.estado = 'C'
      enlace.save
      e1 = Enlace.create(proyecto_id:enlace_py, enevento_id:enevento.id, estado:'C', raiz:enlace.id) 
      #########################################################################
      enevento_proc = Enevento.where(clave:'PROC').first
      Enlace.create(proyecto_id:enlace_py, enevento_id:enevento_proc.id, estado:'C', raiz:e1.id) 
      ########################################################################
            
      data = {result:'ok'}
      respond_to do |format|
          format.json { render json:data.to_json }
      end

  end

  def enterado
    enlace = Enlace.find(params[:enlace_id])

    enlace_py = enlace.proyecto_id
    enevento = Enevento.where(clave:'PROC').first

    enlace.estado = 'C'
    enlace.save

    Enlace.create(proyecto_id:enlace_py, enevento_id:enevento.id, estado:'A', raiz:enlace.id) 

    data = {result:'ok'}
    respond_to do |format|
        format.json { render json:data.to_json }
    end

end

  private
  def enlace_params
      params.require(:enlace).permit(:proyecto_id, :enevento_id, :txtcoment, :estado)
  end

end
