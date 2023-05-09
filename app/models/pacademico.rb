class Pacademico < ApplicationRecord
  self.table_name='py.pacademicos'
  belongs_to :participante
end
