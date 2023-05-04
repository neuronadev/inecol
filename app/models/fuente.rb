class Fuente < ApplicationRecord
  self.table_name='py.fuentes'
  belongs_to :nacionalidad
  belongs_to :lugar
  belongs_to :proyecto
end
