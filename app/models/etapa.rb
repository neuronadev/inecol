class Etapa < ApplicationRecord
  self.table_name = 'py.etapas'
  belongs_to :proyecto
  belongs_to :tevento

 

end
