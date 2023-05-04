class ParticipantesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @proyecto = Proyecto.find(session[:proyecto_id]) 
  end

  def edit
  end

  def update
  end

  def create
  end
end
