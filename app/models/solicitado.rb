class Solicitado < ApplicationRecord
  self.table_name = 'py.solicitados'
  belongs_to :presupuesto
  belongs_to :capitulo
end
