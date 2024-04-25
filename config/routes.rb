Rails.application.routes.draw do
  
  get 'reportes/index'
  get 'reportes/recurso'
  get 'reportes/interinst'
  get 'reportes/cconvenio'
     
  get 'documentos/protocolo'
  get 'documentos/convenio'
  get  'evaleditprot', to: 'documentos#editprotocolo'
  
  post 'documentos/removatach'
  post 'monedas/data'


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
            get 'observa'
            post 'nombrecorto'
            post "cambiarnm"
        end
        member do
            get 'planconv'
            post 'cplanconv'
            get 'eplanconv'
            get 'finalizar'
            post 'cfinalizar'
            get 'sfinalizar'
        end
        resources :mtoautorizados do
                  member do
                      get 'preview'
                  end
        end
        resources :mtoejercidos
        resources :mtoconcurrentes
        resources :prorrogas
        resources :avances
        resources :informes
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
                get 'aceptado'

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
  resources :dictamenes do
            collection do 
                 post 'notificar'
            end
  end
  resources :correos do
             collection do
                post 'enviarmail'
             end
  end
 
  resources :firmas do
        collection do
            post 'generar'
        end
  end

  resources :modificatorios do
        collection do
               get 'mensaje'
               post 'aplicarmod'
        end
  end
   
  root 'proyectos#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
