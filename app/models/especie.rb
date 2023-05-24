class Especie < ApplicationRecord
  self.table_name = 'py.especies'
  belongs_to :recurso
  belongs_to :capitulo

  validates :capitulo_id, presence: true 
  validates :monto, presence: true 
end
