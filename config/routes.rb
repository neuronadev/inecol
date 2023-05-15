Rails.application.routes.draw do
  get 'recursos/index'
  get 'recursos/show'
  get 'recursos/new'
  get 'recursos/edit'
  get 'recursos/update'
  get 'recursos/create'

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
  resources :presupuestos  do
             collection do
                 post 'pyclasifica'
             end
  end

  resources :recursos

  root 'proyectos#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
