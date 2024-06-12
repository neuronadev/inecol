class Mtoejercido < ApplicationRecord
    self.table_name='py.mtoejercidos'
    belongs_to :proyecto

    validates :fecha, presence: true
    validates :monto, presence: true
  
    validate  do |mtoejercido|
       if !mtoejercido.monto.nil?
           Summto.new(mtoejercido).validate
       end    

    end
  
end

class Summto
    def initialize(ejercido)
      @ejercido = ejercido
      @mto_autorizado = Proyecto.find(ejercido.proyecto_id).mtoautorizado.monto
      if !Proyecto.find(ejercido.proyecto_id).mtoejercidos.blank?
           @items_ejercidos = Proyecto.find(ejercido.proyecto_id).mtoejercidos
      else
           @items_ejercidos = []
      end  

    end

    def validate
        suma = @ejercido.monto
        if !@items_ejercidos.blank?
              @items_ejercidos.each do |item|
                   suma += item.monto
              end
        end
        if suma > @mto_autorizado
              @ejercido.errors.add :base, :invalid, message:"La suma total del monto ejercido debe ser menor o igual al monto autorizado"
      end
    end

   
end
