class Aportado < ApplicationRecord
  self.table_name = 'py.aportados'
  belongs_to :recurso
  belongs_to :fondo
  has_many :apmontos
  accepts_nested_attributes_for :apmontos, reject_if: :all_blank, allow_destroy: true

end
