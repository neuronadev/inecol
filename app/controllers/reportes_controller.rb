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

  def pinvfin
      @enlace = Enlace.includes(:enevento).where('eneventos.clave':'DICT')
      data = []

      @enlace.each do |e|
          f_inicio = e.proyecto.mtoautorizado.finicio.strftime("%d-%m-%Y") if !e.proyecto.mtoautorizado.nil?  
          f_termino = e.proyecto.mtoautorizado.ftermino.strftime("%d-%m-%Y") if !e.proyecto.mtoautorizado.nil?
          porcen_sum = e.proyecto.avances.sum(:porcentaje).to_s + '%' if e.proyecto.avances.any?
          mto_aut = number_to_currency(e.proyecto.mtoautorizado.monto, :unit=>"$ ") if !e.proyecto.mtoautorizado.nil?
          mto_ejer = number_to_currency(e.proyecto.mtoejercidos.sum(:monto), :unit=>"$ ") if e.proyecto.mtoejercidos.any?
          resp_tec =  e.proyecto.participante.pacademicos.where(responsable:true).first.academico.persona.nom_espacio
          data << { nombre:e.proyecto.nombre, 
                    fuente:e.proyecto.fuente.nomfuente,
                    tipoproy:e.proyecto.clasificacion.nomclasifica,
                    finicio:f_inicio,
                    ftermino:f_termino,
                    porcentaje:porcen_sum,
                    montoaut:mto_aut,
                    montoejer:mto_ejer,
                    resp:resp_tec
                  }
      end
     
      respond_to do |format|
            format.json { render json:data.to_json }
      end
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
            elsif current_usuario.cuenta.rol.clave == 'DIR'
                   return 'direccion'
            else
                  return 'proyectos'
            end
               
       end

 end        


end
