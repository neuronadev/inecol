class Solfirma < ApplicationRecord
  self.table_name = 'py.solfirmas'
  belongs_to :proyecto
end
