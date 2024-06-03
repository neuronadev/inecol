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
      d = proyecto.docprotocolos.attach(params[:idsigned])
      data = {success:d}
      puts data
      respond_to do |format|
          format.json { render json:data.to_json }
      end

  end

  def removatach
        attachment = ActiveStorage::Attachment.find(params[:doc_id])
        if !attachment.nil?
            Dhistorico.create!(name:attachment.name, record_type:attachment.record_type, record_id:attachment.record_id, blob_id:attachment.blob_id)
            attachment.delete  # or use purge
            data = { result:'ok' }
        else
            data = { result:'ok' } 
       end
       
       respond_to do |format|
              format.json { render json:data.to_json }
       end
  end
  
end
