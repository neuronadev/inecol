Rails.application.routes.draw do
  devise_for :usuarios
  resources :proyectos do
        collection do
            get 'institucion'
            post 'tipomedio'
            post 'tipoclasifica'
            post 'medclave'
        end
  end

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

  resources :recursos
  resources :metas
  resources :vistas do
            collection do
                get 'resumen'
                get 'secproyecto'
            end
  end
  
  
  root 'proyectos#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
