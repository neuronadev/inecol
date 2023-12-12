class Firma < ApplicationRecord
  self.table_name='py.firmas'
  belongs_to :evaluador
  belongs_to :proyecto
end
