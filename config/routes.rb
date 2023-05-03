Rails.application.routes.draw do
  resources :proyectos do
        collection do
            get 'institucion'
        end
  end
  
  root 'proyectos#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
