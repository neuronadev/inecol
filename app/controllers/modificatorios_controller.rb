class ModificatoriosController < ApplicationController
   
   def mensaje
       @proyecto = Proyecto.find(params[:idpy].to_i)
   end

   def aplicarmod
            @proyecto = Proyecto.find(params[:idpy])

            proyecto_mod = regproyecto @proyecto
            fuente = regfuente @proyecto.fuente, proyecto_mod.id
            participantes = regparts @proyecto.participante, proyecto_mod.id
            presupuesto = regpresup @proyecto.presupuesto, proyecto_mod.id
            recurso = regrecurso @proyecto.recurso, proyecto_mod.id
            meta = regmeta @proyecto.meta, proyecto_mod.id

            r = { "mensaje":"success", "fecha": proyecto_mod.created_at.strftime("%d-%m-%Y %H:%M") }
            #r = { "mensaje":"success", "fecha": "XXXXX" }

            respond_to do |format|
                format.json { render json: r }
            end
   end

   def regproyecto p
        file = ''
        @proyecto_reg = ''

        p_convoca =  nil
        p_instituc = Array.new

        if !p.mconvocatoria.nil?
             p_convoca =  { nomconvocatoria: p.mconvocatoria.nomconvocatoria, link: p.mconvocatoria.link }
        end

        if p.instituciones.any?
             p.instituciones.each do |i|
                   p_instituc.push( { nominstitucion: i.nominstitucion, _destroy:'0' } )
             end    
        end
        
        params = {
            proyecto:{
                  nombre:p.nombre,
                  clasificacion_id: p.clasificacion_id,
                  medio_id: p.medio_id,
                  linea_id: p.linea_id,
                  tfconoc: p.tfconoc,
                  interinst: p.interinst,
                  periodo: p.periodo,
                  overhead: p.overhead,
                  persona_id: p.persona_id,
                  objetivo: p.objetivo,
                  mconvocatoria_attributes: !p_convoca.nil? ? p_convoca : {},
                  instituciones_attributes: !p_instituc.nil? ? p_instituc : []
            }
         }
         
         @proyecto_reg = Proyecto.create(params[:proyecto]) do |proyecto|
                                       p.docprotocolos.each do |doc|
                                           file = Rails.root.join(ActiveStorage::Blob.service.path_for(doc.key)).open('rb')
                                           proyecto.docprotocolos.attach(io: file, filename: 'protocolotmp.pdf', content_type: 'application/pdf')
                                       end    
                                   end
                                   file.close

        #@proyecto_reg = Proyecto.create!(
        #                          nombre:p.nombre,
        #                          clasificacion_id: p.clasificacion_id,
        #                          medio_id: p.medio_id,
        #                          linea_id: p.linea_id,
        #                          tfconoc: p.tfconoc,
        #                          interinst: p.interinst,
        #                          periodo: p.periodo,
        #                          overhead: p.overhead,
        #                          persona_id: p.persona_id,
        #                          objetivo: p.objetivo
        #                        ) do |proyecto|
        #                               file = Rails.root.join(ActiveStorage::Blob.service.path_for(p.docprotocolo.key)).open('rb')
        #                               proyecto.docprotocolo.attach(io: file, filename: 'protocolotmp.pdf', content_type: 'application/pdf')
        #                          end
        #                          file.close

        @proyecto_reg.modificatorio = 'SI'
        @proyecto_reg.raiz = p.id
        @proyecto_reg.save
        
        tevento = Tevento.where(clave:'CAP').first
        Etapa.create!(proyecto_id:@proyecto_reg.id, tevento_id:tevento.id)                
     
        return @proyecto_reg
   end

   def regfuente fuente, proy_mod_id

       fuente_reg = Fuente.create!(
                   nomfuente: fuente.nomfuente,
                   nacionalidad_id: fuente.nacionalidad_id,
                   lugar_id: fuente.lugar_id,
                   proyecto_id: proy_mod_id,
                   nomcontacto: fuente.nomcontacto,
                   emailcontacto: fuente.emailcontacto
       )
       return fuente_reg
   end

   def regparts part, proy_mod_id
       if part.pacademicos.any?
             acad_attr = regacademicos part.pacademicos, 0
       end
       if part.ptecnicos.any?
             tec_attr = regtecnicos part.ptecnicos, 0
       end
       if part.pestudiantes.any?
             est = regestudiantes part.pestudiantes, 0
       end
       
       params = {
               participante:{
                     proyecto_id: proy_mod_id,
                     tparticipante_id: part.tparticipante_id,
                     pacademicos_attributes: !acad_attr.nil? ? acad_attr : [],
                     ptecnicos_attributes: !tec_attr.nil? ? tec_attr : [],
                     pestudiantes_attributes: !est.nil? ? est : []
               }
            }
        participante = Participante.create(params[:participante])

       return participante
   end

   def regacademicos pacademicos, reg_part_id
          array_d = Array.new
          pacademicos.each do |academico|
               array_d.push({ porcentaje: academico.porcentaje.to_f, responsable: academico.responsable, academico_id: academico.academico_id, _destroy:'0' })
          end
         
          if array_d.length > 0
              return array_d 
          else
              return []    
          end    
   end

   def regtecnicos ptecnicos, reg_part_id
            array_d = Array.new
            ptecnicos.each do |tecnico|
                array_d.push({ porcentaje: tecnico.porcentaje.to_f, academico_id: tecnico.academico_id, _destroy:'0' })
            end
            if array_d.length > 0
                return array_d 
            else
                return []    
            end   
          
    end

    def regestudiantes pestudiantes, reg_part_id
        array_d = Array.new
        pestudiantes.each do |estudiante|
            array_d.push({ nivel_id: estudiante.nivel_id, nombre: estudiante.nombre, _destroy:'0' })
        end

        if array_d.length > 0
            return array_d 
        else
            return []
        end   
    end

    def regpresup prep, proy_mod_id
        array_d = Array.new
        prep.solicitados.each do |solicitado|
            array_d.push({ capitulo_id: solicitado.capitulo_id.to_i, monto: solicitado.monto.to_f, _destroy: '0' })
        end

         params = {
            presupuesto:{
                proyecto_id: proy_mod_id,
                moneda_id: prep.moneda_id,
                costo: prep.costo,
                iva: prep.iva,
                tproyecto: prep.tproyecto,
                overhead: prep.overhead,
                estimulo: prep.estimulo,
                tgastos: prep.tgastos,
                solicitados_attributes: !array_d.nil? ? array_d : []
            }
         }
         presupuesto = Presupuesto.create(params[:presupuesto])
      return presupuesto   
    end

    def regrecurso recurso, proy_mod_id
         d_fiscales = Array.new
         d_especies = Array.new
         d_concurrentes = Array.new

         recurso.fiscales.each do |fis|
              d_fiscales.push({ capitulo_id: fis.capitulo_id.to_i, monto: fis.monto.to_f, _destroy: '0' })
         end
         recurso.especies.each do |es|
             d_especies.push({ capitulo_id: es.capitulo_id.to_i, monto: es.monto.to_f, _destroy: '0' })
         end
         recurso.concurrentes.each do |conc|
             d_concurrentes.push({ capitulo_id: conc.capitulo_id.to_i, monto: conc.monto.to_f, _destroy: '0' })
         end

         params = {
             recurso:{  
                proyecto_id: proy_mod_id,
                omitir: recurso.omitir,
                fiscales_attributes: !d_fiscales.nil? ? d_fiscales : [],
                especies_attributes: !d_especies.nil? ? d_especies : [],
                concurrentes_attributes: !d_concurrentes.nil? ? d_concurrentes : []
            }    
         }

         file = ''
         if recurso.doficio.attached?
                recurso_reg = Recurso.create(params[:recurso]) do |recurso_doc|
                    file = Rails.root.join(ActiveStorage::Blob.service.path_for(recurso_doc.doficio.key)).open('rb')
                    recurso_doc.doficio.attach(io: file, filename: 'docrecurso.pdf', content_type: 'application/pdf')
                end
                file.close
         else
            recurso_reg = Recurso.create(params[:recurso])
         end
      return recurso_reg
    end

    def regmeta meta, proy_mod_id
        params = {
              meta:{
                  proyecto_id: proy_mod_id, 
                  esperado: meta.esperado, 
                  impacto: meta.impacto, 
                  comentario: meta.comentario
              }
        }
        meta = Meta.create(params[:meta])
    end
   

end