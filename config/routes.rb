Rails.application.routes.draw do

  resources :proyectos do
        collection do
            get 'institucion'
        end
  end

  resources :fuentes do
        collection do
            post 'lugar'
        end
  end
  
  resources :participantes
  resources :presupuestos 

  root 'proyectos#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
