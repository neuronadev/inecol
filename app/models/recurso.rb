class Recurso < ApplicationRecord
  self.table_name = 'py.recursos'
  belongs_to :proyecto
  has_many :fiscales, dependent: :destroy, inverse_of: :recurso
  accepts_nested_attributes_for :fiscales,  allow_destroy: true

  has_many :especies, dependent: :destroy, inverse_of: :recurso
  accepts_nested_attributes_for :especies,  allow_destroy: true

  has_many :concurrentes, dependent: :destroy, inverse_of: :recurso
  accepts_nested_attributes_for :concurrentes,  allow_destroy: true
 
end
