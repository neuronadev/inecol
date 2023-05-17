class ParticipantesController < ApplicationController
  def index
  end

  def show
      @participante = Participante.find(params[:id])
  end

  def new
    @proyecto = Proyecto.find(session[:proyecto_id]) 
    @participante = Participante.new
    @participante.pacademicos.build
    @participante.pestudiantes.build
  end

  def edit
      @participante = Participante.find(params[:id]) 

  end

  def update
  end

  def create
       @participante = Participante.new(participante_params)
       respond_to do |format|
            if @participante.save
                  Nav::stepInc 
                  session[:step] += 1
                  format.html { redirect_to new_presupuesto_path } 
            else
                  format.html { render :new, status: :bad_request }
            end
       end    
  end

  private
  def participante_params
       params.require(:participante).permit(
                        :proyecto_id, 
                        :tparticipante_id,
                        pacademicos_attributes:[:id, :academico_id, :responsable, :porcentaje, :_destroy],
                        pestudiantes_attributes:[:id, :nombre, :nivel_id, :_destroy]
                     )
  end
end
