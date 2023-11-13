class ReportesController < ApplicationController
  def index
  end

  def recurso
      @enlace = Enlace.includes(:enevento).where('eneventos.clave':'DICT')
  end

  def interinst
      @proyectos = Proyecto.where(interinst:true)
  end

  def cconvenio
  end


end
