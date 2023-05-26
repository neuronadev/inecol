class ApplicationController < ActionController::Base
    protect_from_forgery unless: -> { request.format.json? }
    add_flash_types :info, :error, :warning
    before_action :authenticate_usuario!
    
end
