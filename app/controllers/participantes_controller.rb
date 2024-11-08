class ParticipantesController < ApplicationController
  def index
  end

  def show
      @participante = Participante.find(params[:id])
      @proyecto = @participante.proyecto
      @inv = @participante.pacademicos.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'INV')
      @tec = @participante.pacademicos.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'TEC')
      @est = @participante.pestudiantes

      @inv_sum = @participante.pacademicos.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'INV').sum('pacademicos.porcentaje')
      @tec_sum = @participante.pacademicos.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'TEC').sum('pacademicos.porcentaje')
      @tot_porc = @inv_sum.to_f + @tec_sum.to_f
  end

  def new
    @proyecto = Proyecto.find(session[:proyecto_id]) 
    @participante = Participante.new
    @participante.pacademicos.build
    @participante.pestudiantes.build
  end

  def edit
      @participante = Participante.find(params[:id]) 
      @inv_sum = @participante.pacademicos.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'INV').sum('pacademicos.porcentaje')
      @tec_sum = @participante.pacademicos.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'TEC').sum('pacademicos.porcentaje')
      @tot_porc = @inv_sum.to_f + @tec_sum.to_f
  end

  def update
      @participante = Participante.find(params[:id])
      @participante.update(participante_params)
      respond_to do |format|
           if @participante.save
               format.html { redirect_to participante_path(@participante) }
           else
               format.html { render :edit, status: :bad_request }
           end
      end
  end

  def create
       @participante = Participante.new(participante_params)
       @proyecto = Proyecto.find(@participante.proyecto_id)
       respond_to do |format|
            if @participante.save
                  session[:step] += 1
                  format.html { redirect_to new_presupuesto_path } 
            else
                  flash.now[:notice] = 'La infomación esta incompleta, favor de revisar los errores'
                  p '------------Errores------------'
                  p @participante.errors
                  format.html { render :new, status: :bad_request }
            end
       end    
  end

  def tipopart
      academico = Academico.find(params[:academico_id])
      data = {nomtipo:academico.tacademico.nomtacademico}
      respond_to do |format|
        format.json { render json:data.to_json }
      end
  end

  private
  def participante_params
       params.require(:participante).permit(
                        :proyecto_id, 
                        :tparticipante_id,
                        pacademicos_attributes:[:id, :academico_id, :responsable, :porcentaje, :_destroy],
                        ptecnicos_attributes:[:id, :academico_id, :porcentaje, :_destroy],
                        pestudiantes_attributes:[:id, :nombre, :nivel_id, :_destroy]
                     )
  end
end