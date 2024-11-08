class ImpuestosController < ApplicationController
  def index
  end

  def show
      @impuesto = Impuesto.find(params[:id].to_i)    
      @presupuesto = Presupuesto.find(params[:presupuesto_id].to_i) 
      @proyecto = Proyecto.find(params[:proyecto_id].to_i) 
      @moneda = @presupuesto.moneda
  end

  def edit
      @impuesto = Impuesto.find(params[:id].to_i)    
      @presupuesto = Presupuesto.find(params[:presupuesto_id].to_i) 
      @proyecto = Proyecto.find(params[:proyecto_id].to_i) 
      @moneda = @presupuesto.moneda
  end

  def new
  end

  def create
  end

  
end
