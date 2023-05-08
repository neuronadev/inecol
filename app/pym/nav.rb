class Nav
   
    @@step = 2
    @@steps = ['proyectos', 'fuentes', 'participantes', 'presupuestos', 'aportados']

    def self.wizard_next(c, a, p)  # c = Nombre del controlador actual. a = Accion del controlador. p = proyecto id almacenado en la sesion. ejem: fuentes/new
        step_nav = @@steps.index c 
        proyecto = Proyecto.find(p)
        if step_nav.to_i == @@step.to_i
            url = '/' + @@steps[step_nav - 1] << p.to_s
            str_nav = "<a href=#{url}>Anterior</a>"
            return str_nav
        end

        if step_nav < @@step
            if (step_nav + 1) == @@step
                  url =  '/' + @@steps[step_nav + 1] + '/new'
                  str_nav = "<a href=#{url}>Siguiente</a>"
                  return str_nav
            else
                  url = '/' + @@steps[step_nav + 1] + '/' << p.to_s
                  str_nav = "<a href=#{url}>Siguiente</a>"
                  return str_nav 
            end
        end

    end


    def self.wizard_back(c, a, p)
        p '--------------------- back'
        p @@step
        if c == 'fuentes' && ['new','show'].include?(a)
                url = '/proyectos/' << p.to_s
                "<a href=#{url}>Anterior</a>"
        elsif c == 'proyectos' && a == 'show'
               if @@step == 1
                  url = '/fuentes/new'
                  "<a href=#{url}>Anterior</a>"
               end    
        else
            '' 
        end
    end

    def self.stepInc
         @@step += 1
    end
    def self.stepAct
         @@step
    end

end