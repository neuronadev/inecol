class PeriodosController < ApplicationController
  def index
  end

  def listado
    anio = params[:periodo]
    @periodo = Periodo.where(anio:anio).first
    
    if @periodo.anio == 2024
         render partial: 'listado'
    end

    if @periodo.anio == 2025
        render partial: 'listadoper'
    end


  end

end
