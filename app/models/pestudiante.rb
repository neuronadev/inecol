class Pestudiante < ApplicationRecord
  self.table_name='py.pestudiantes'
  belongs_to :participante
  belongs_to :nivel
end
