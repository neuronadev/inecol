class ParticipantesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @proyecto = Proyecto.find(session[:proyecto_id]) 
    @participante = Participante.new
    @participante.pacademicos.build
    @participante.pestudiantes.build
  end

  def edit
  end

  def update
  end

  def create
  end
end
