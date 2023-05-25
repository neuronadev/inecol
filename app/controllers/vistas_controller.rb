class VistasController < ApplicationController
    layout 'vistas'
    def resumen
        @proyecto = Proyecto.find(params[:id])
        @fuente = @proyecto.fuente
    end
    
    def secproyecto
        @proyecto = Proyecto.find(params[:id])
        @fuente = @proyecto.fuente 
    end

end
