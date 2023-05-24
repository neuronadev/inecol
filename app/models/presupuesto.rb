class Presupuesto < ApplicationRecord
  self.table_name = 'py.presupuestos'
  belongs_to :proyecto
  belongs_to :moneda
  has_many :solicitados, dependent: :destroy, inverse_of: :presupuesto
  accepts_nested_attributes_for :solicitados, reject_if: :all_blank, allow_destroy: true

  validates :costo, presence: true
  validates :moneda_id, presence: true
  validates :solicitados, presence: true
  

end
