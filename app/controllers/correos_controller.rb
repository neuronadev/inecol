require 'util/email.rb'

class CorreosController < ApplicationController
    def enviarmail
            params={nproyecto:"Aves del santuario INECOL", responsable:"Aguirre Jaimes Armando"}
            data = Util::Email.proyecto_enlace("antonio.francisco@inecol.mx", "noreply@inecol.mx", params, "d-a588d4f9befe40cdb1aa4d32b02d20f4")
            respond_to do |format|
                format.json { render json: data }
            end
    end
end