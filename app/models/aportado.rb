class Aportado < ApplicationRecord
  self.table_name = 'py.aportados'
  belongs_to :fondo
  

end
