class Pacademico < ApplicationRecord
  self.table_name='py.pacademicos'
  belongs_to :participante
  belongs_to :academico
end
