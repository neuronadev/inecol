class ReportesController < ApplicationController
  layout :select_layout
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

  protected 
  def select_layout
     
     if !current_usuario.nil?
          if current_usuario.cuenta.rol.clave == 'EL'
                return 'enlaces' 
          elsif current_usuario.cuenta.rol.clave == 'EVAL'
                return 'validaciones'
          elsif current_usuario.cuenta.rol.clave == 'PLAN'
                return 'planeacion'
          else
                return 'proyectos'
          end
             
     end

 end        


end
