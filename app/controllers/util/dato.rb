module Util
    module Dato
          def self.numregmod idproyecto
               @proyecto = Proyecto.find(idproyecto)
               loop do
                      if @proyecto.modificatorio == 'SI'
                            @proyecto =  Proyecto.find(@proyecto.raiz)
                      else
                            if !@proyecto.dictamen.nil?
                                 return @proyecto.dictamen.numregistro
                            else
                                 return 0 
                            end
                            break
                      end
               end

               return 12345
          end    
    end
end    