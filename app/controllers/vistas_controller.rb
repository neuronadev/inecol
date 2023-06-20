class VistasController < ApplicationController
    layout 'vistas'
    def resumen
        
        @proyecto = Proyecto.find(params[:id])
        @total_notifica_rp = @proyecto.enlaces.where(estado:'A').includes(:enevento).where('eneventos.clave':'CORR').count  
        @total_notifica_sola = @proyecto.enlaces.where(estado:'A').includes(:enevento).where('eneventos.clave':'SOLA').count
        

        #@total_notifica_rp = @proyecto.enlaces.where(estado:'A').includes(:enevento).where('eneventos.clave':'CORR').count
        #@total_notifica_sola = @proyecto.enlaces.includes(:enevento).where('eneventos.clave':'SOLA').count

        #if @total_notifica_rp > 0
        #    @notifica_corr = @proyecto.enlaces.where(estado:'A').includes(:enevento).where('eneventos.clave':'CORR')
        #end
        
        #if @total_notifica_sola > 0
        #    @notifica_sola = @proyecto.enlaces.includes(:enevento).where('eneventos.clave':'SOLA')
        #end

    end
    
    def secproyecto
        @proyecto = Proyecto.find(params[:id])
        @fuente = @proyecto.fuente 
    end

end
