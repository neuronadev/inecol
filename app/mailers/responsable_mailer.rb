class ResponsableMailer < ApplicationMailer
      def notificar_envio
           @proyecto_m = Proyecto.find(params[:id]) 
           mail(to: 'sara.sanchez@inecol.mx', subject: "Proyecto", reply_to: 'no-reply@inecol.mx').deliver!
      end

      def notificar_corregir
            @proyecto_m = params[:p]
            @enlace_m = params[:e]
            p = @proyecto_m.persona
            c = Cuenta.where(persona_id:p.id).first
            u = Usuario.find(c.usuario_id) 
            m = u.email 
            mail(to: m, subject: "Corregir información del proyecto", reply_to: 'sara.sanchez@inecol.mx').deliver!  
      end
end