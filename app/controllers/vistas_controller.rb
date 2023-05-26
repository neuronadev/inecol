class VistasController < ApplicationController
    layout 'vistas'
    def resumen
        @proyecto = Proyecto.find(params[:id])
        #@fuente = @proyecto.fuente
        @total_notifica_rp = @proyecto.enlaces.where(estado:'A').includes(:enevento).where('eneventos.clave':'CORR').count
        if @total_notifica_rp > 0
            @notifica_corr = @proyecto.enlaces.where(estado:'A').includes(:enevento).where('eneventos.clave':'CORR')
        end
    end
    
    def secproyecto
        @proyecto = Proyecto.find(params[:id])
        @fuente = @proyecto.fuente 
    end

end
