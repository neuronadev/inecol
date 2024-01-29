class Periodo < ApplicationRecord
  self.table_name='py.periodos' 
  belongs_to :contenedor
end
