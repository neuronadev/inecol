module Seguimiento
    extend ActiveSupport::Concern
   
    def self.activarseg proyecto, tipo
        seguir = true
        py_ids = []
        proy_itera = proyecto

        while seguir
              if proy_itera.modificatorio == 'SI'
                   proy_itera = Proyecto.find(proy_itera.raiz)
                   py_ids << proy_itera.id
              else
                  seguir = false
              end
        end
        if !py_ids.blank?
             py_ids.each do |item|
                  p = Proyecto.find(item)
                  if tipo == 'SEG' 
                      p.seguimiento = true
                  end   

                  if tipo == 'FIN' 
                      p.finalizado = true
                  end   

                  p.save
             end
        else
             puts "No hay IDS de Modificatorios."     
        end    

    end

end