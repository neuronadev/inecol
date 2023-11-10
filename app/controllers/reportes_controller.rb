class ReportesController < ApplicationController
  def index
  end

  def recurso
      @enlace = Enlace.includes(:enevento).where('eneventos.clave':'DICT')
  end

  def interinst
  end

  def cconvenio
  end


end
