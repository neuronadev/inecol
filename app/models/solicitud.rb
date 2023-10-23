class Solicitud < ApplicationRecord
  self.table_name='py.solicitudes'
  belongs_to :proyecto
end
