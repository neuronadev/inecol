class DocumentosController < ApplicationController
  def protocolo
       @proyecto = Proyecto.find(params[:idpy]) 
  end

  def convenio
       @proyecto = Proyecto.find(params[:idpy]) 
  end
end
