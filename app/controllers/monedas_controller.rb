class MonedasController < ApplicationController
    def data
         m = Moneda.find(params[:idmoneda])
         respond_to do |format|
              format.json { render json:m.to_json }
         end
    end
end