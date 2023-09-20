Rails.application.routes.draw do
  
  get 'documentos/protocolo'
  get 'documentos/convenio'
  post 'documentos/removatach'
  
  devise_for :usuarios
  resources :proyectos do
        collection do
            get 'institucion'
            post 'tipomedio'
            post 'tipoclasifica'
            post 'medclave'
            post 'enviar'
            get 'continuar'
            post 'eliminar'
        end
        resources :mtoautorizados
        resources :mtoejercidos
        resources :mtoconcurrentes
  end
resources :mtoautorizados
resources :mtoejercidos
resources :mtoconcurrentes
  #resources :proyectos do
  #         resources :mtoautorizados
  #end

  resources :fuentes do
        collection do
            post 'lugar'
        end
  end
  
  resources :participantes do
            collection do
                post 'tipopart'
            end
  end

  resources :presupuestos  do
             collection do
                 post 'pyclasifica'
             end
  end

  resources :recursos do
            collection do
                get 'omitir'
            end
  end
  resources :metas
  resources :vistas do
            collection do
                get 'resumen'
                get 'secproyecto'
                get 'notifica'
            end
  end
  
  resources :enlaces do
             collection do
                  get 'mensaje'
                  post 'atendido'
                  post 'enterado'
             end
  end


  resources :validaciones 
  resources :dictamenes
  resources :correos do
             collection do
                post 'enviarmail'
             end
  end

  root 'proyectos#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
