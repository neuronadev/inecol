class Persona < ApplicationRecord
  self.table_name='rh.personas'
  belongs_to :tpersona
end
