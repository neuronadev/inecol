class MtoautorizadosController < ApplicationController
  def index
      
  end

  def show
  end

  def new
      @proyecto = Proyecto.find(params[:proyecto_id])
      @mtoautorizado = Mtoautorizado.new
  end

  def edit
  end

  def update
  end

  def create
  end
end
