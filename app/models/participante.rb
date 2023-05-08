class Participante < ApplicationRecord
  self.table_name='py.participantes'
  belongs_to :proyecto
  belongs_to :participable, polymorphic: true
end
