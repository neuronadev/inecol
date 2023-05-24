class Solicitado < ApplicationRecord
  self.table_name = 'py.solicitados'
  belongs_to :presupuesto
  belongs_to :capitulo

  validates :capitulo_id, presence: true
  validates :monto, presence: true

  

end
