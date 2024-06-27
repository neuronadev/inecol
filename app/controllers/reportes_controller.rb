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

  def pinvinter
      proyectos = Proyecto.where(interinst:true).includes(enlaces: :enevento).where('eneventos.clave':'DICT')
      data = []

      proyectos.each do |p|
          f_inicio = p.mtoautorizado.finicio.strftime("%d-%m-%Y") if !p.mtoautorizado.nil?
          f_termino = p.mtoautorizado.ftermino.strftime("%d-%m-%Y") if !p.mtoautorizado.nil?
          porcen_sum = p.avances.sum(:porcentaje).to_s + '%' if p.avances.any?
 
          str = ''
          t = p.instituciones.count
          x = 1
          p.instituciones.each do |i| 
                str += i.nominstitucion
                if x < t
                    str += ', '
                end
                x += 1
          end 

           estadop = p.etapas.last.tevento.clave == 'ACEP' ? 'En proceso' : p.etapas.last.tevento.clave == 'FIN' ? 'Terminado' : ''

          if !p.mtoautorizado.nil?
                mto_aut = format('$%.2f', p.mtoautorizado.monto)
          else
                mto_aut =  format('$%.2f', 0.0)
          end

          if p.mtoejercidos.any?
                mto_ejer = format('$%.2f', p.mtoejercidos.sum(:monto))
          else
                mto_ejer =  format('$%.2f', 0.0)
          end


          #mto_aut = e.proyecto.mtoautorizado.monto if !e.proyecto.mtoautorizado.nil?
          #mto_ejer = e.proyecto.mtoejercidos.sum(:monto) if e.proyecto.mtoejercidos.any?

          resp_tec =  p.participante.pacademicos.where(responsable:true).first.academico.persona.nom_espacio
          comentarios = p.avances.last.txtavance.body.to_plain_text if !p.avances.blank?
          data << { nombre:p.nombre, 
                    fuente:p.fuente.nomfuente,
                    tipoproy:p.clasificacion.nomclasifica,
                    finicio:f_inicio,
                    ftermino:f_termino,
                    porcentaje:porcen_sum,
                    montoaut:mto_aut,
                    montoejer:mto_ejer,
                    resp:resp_tec,
                    comen:comentarios,
                    inst:str,
                    status:estadop
                  }
      end
     
      respond_to do |format|
            format.json { render json:data.to_json }
      end

  end

  def pinvfin
      @enlace = Enlace.includes(:enevento).where('eneventos.clave':'DICT')
      data = []

      @enlace.each do |e|
          f_inicio = e.proyecto.mtoautorizado.finicio.strftime("%d-%m-%Y") if !e.proyecto.mtoautorizado.nil?
          f_termino = e.proyecto.mtoautorizado.ftermino.strftime("%d-%m-%Y") if !e.proyecto.mtoautorizado.nil?
          porcen_sum = e.proyecto.avances.sum(:porcentaje).to_s + '%' if e.proyecto.avances.any?

          if !e.proyecto.mtoautorizado.nil?
                mto_aut = format('$%.2f', e.proyecto.mtoautorizado.monto)
          else
                mto_aut =  format('$%.2f', 0.0)
          end

          if e.proyecto.mtoejercidos.any?
                mto_ejer = format('$%.2f', e.proyecto.mtoejercidos.sum(:monto))
          else
                mto_ejer =  format('$%.2f', 0.0)
          end

          resp_tec =  e.proyecto.participante.pacademicos.where(responsable:true).first.academico.persona.nom_espacio
          
          comentarios = ''
          e.proyecto.avances.each do |v|
                comentarios += v.txtavance.body.to_plain_text
          end
          if e.proyecto.etapas.last.tevento.clave == 'FIN'
                comentarios += e.proyecto.txtlogro.body.to_plain_text
          end

          data << { nombre:e.proyecto.nombre, 
                    fuente:e.proyecto.fuente.nomfuente,
                    tipoproy:e.proyecto.clasificacion.nomclasifica,
                    finicio:f_inicio,
                    ftermino:f_termino,
                    porcentaje:porcen_sum,
                    montoaut:mto_aut,
                    montoejer:mto_ejer,
                    resp:resp_tec,
                    comen:comentarios
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
