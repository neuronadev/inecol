class DocumentosController < ApplicationController
  def protocolo
       @proyecto = Proyecto.find(params[:idpy]) 
  end

  def convenio
       @proyecto = Proyecto.find(params[:idpy]) 
  end

  def removatach
     attachment = ActiveStorage::Attachment.find(params[:doc_id])
     
     Dhistorico.create!(name:attachment.name, record_type:attachment.record_type, record_id:attachment.record_id, blob_id:attachment.blob_id)
     
     attachment.delete  # or use purge
     data = { result:'ok' }

     respond_to do |format|
       format.json { render json:data.to_json }
     end
  end
  
end