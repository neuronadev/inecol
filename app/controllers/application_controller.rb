class ApplicationController < ActionController::Base
    add_flash_types :info, :error, :warning
    before_action :authenticate_usuario!
    before_action :select_layout
    layout :select_layout
    
    protected 
     def select_layout
        
        if !current_usuario.nil?
              'proyectos'
        end
    end        
end
