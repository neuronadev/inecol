class ResponsableMailer < ApplicationMailer
      def notificar_envio
           mail(to: 'antonio.francisco@inecol.mx', subject: "Proyecto")
      end
end
