class Apmonto < ApplicationRecord
  self.table_name='py.apmontos'
  belongs_to :aportado
  belongs_to :capitulo

  validates :capitulo_id, presence: true
  validates :monto, presence: true

end
