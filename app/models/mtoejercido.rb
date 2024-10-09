class Mtoejercido < ApplicationRecord
    self.table_name='py.mtoejercidos'
    belongs_to :proyecto

    validates :fecha, presence: true
    validates :monto, presence: true
  
    validate  do |mtoejercido|
       if !mtoejercido.monto.nil?
           Summto.new(mtoejercido).validate
           Fechas.new(mtoejercido).validate
       end  

    end
end

class Fechas
    def initialize(ejercido)
        @fecha_ini = nil
        @fecha_fin = nil
        @ejercido = ejercido
        @py = Proyecto.find(ejercido.proyecto_id)
    end

    def validate
        @fecha_act = Time.new
        if !@py.mtoautorizado.nil?
            @fecha_ini = @py.mtoautorizado.finicio
            @fecha_fin = @py.mtoautorizado.ftermino
        end
  
       if @py.prorrogas.any?
           @fecha_fin = @py.prorrogas.order(:created_at).last.fecha
       end

        if !(@ejercido.fecha >= @fecha_ini && @ejercido.fecha <= @fecha_fin)
              @ejercido.errors.add :fecha, :invalid, message:"La fecha seleccionada esta fuera del rango de fecha de inicio y fecha de termino"
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
