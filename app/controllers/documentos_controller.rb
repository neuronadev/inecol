class DocumentosController < ApplicationController
  def protocolo
       @proyecto = Proyecto.find(params[:idpy]) 
  end

  def convenio
       @proyecto = Proyecto.find(params[:idpy]) 
  end

  def editprotocolo
      @proyecto = Proyecto.find(params[:idpy]) 
  end

  def agregar
      proyecto = Proyecto.find(params[:idproyecto].to_i)
      if params[:tipo] == 'protocolo'
          d = proyecto.docprotocolos.attach(params[:idsigned])
      end
      if params[:tipo] == 'convenio'
         d = proyecto.docconvenios.attach(params[:idsigned])
      end

      data = {success:d}

      respond_to do |format|
          format.json { render json:data.to_json }
      end

  end

  def removatach
        attachment = ActiveStorage::Attachment.find(params[:doc_id])
        if !attachment.nil?
            evento = Tevento.where(clave:'REV').first
            etapa = Etapa.where(proyecto_id:attachment.record_id, tevento_id:evento.id) 

            if etapa.any?
                 Dhistorico.create!(name:attachment.name, record_type:attachment.record_type, record_id:attachment.record_id, blob_id:attachment.blob_id)
            end

            attachment.delete  # or use purge
            data = { result:'ok' }
            
        else
            data = { result:'ok' } 
        end
       
       respond_to do |format|
              format.json { render json:data.to_json }
       end
  end

  def removatachel
        blob = ActiveStorage::Blob.find_signed(params[:idsigned])

        #p blob.attachments
        if blob
            if blob.attachments.any?
                blob.attachments.each { |attachment|
                                         Dhistorico.create!(name:attachment.name, record_type:attachment.record_type, record_id:attachment.record_id, blob_id:attachment.blob_id)
                                         attachment.delete 
                                      }  #or purge
            end
            render json: { result: "ok" }
        else
            head :unprocessable_entity
        end

  end
  
end
