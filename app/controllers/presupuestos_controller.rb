class PresupuestosController < ApplicationController
  def index
  end

  def show
  end

  def new
      @proyecto = Proyecto.find(session[:proyecto_id]) 
      @presupuesto = Presupuesto.new
      @presupuesto.solicitados.build
  end

  def edit
  end

  def update
  end

  def create
  end
end
