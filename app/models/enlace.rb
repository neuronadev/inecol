class Enlace < ApplicationRecord
  self.table_name = 'py.enlaces'
  belongs_to :proyecto
  belongs_to :enevento
end
