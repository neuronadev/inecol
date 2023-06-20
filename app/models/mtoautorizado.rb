class Mtoautorizado < ApplicationRecord
  self.table_name='py.mtoautorizados'
  belongs_to :proyecto
end
