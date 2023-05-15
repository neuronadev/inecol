class Recurso < ApplicationRecord
  self.table_name = 'py.recursos'
  belongs_to :proyecto
  has_many :aportados
  accepts_nested_attributes_for :aportados, reject_if: :all_blank, allow_destroy: true
end
