class Convenio < ApplicationRecord
  self.table_name = 'py.convenios'
  belongs_to :proyecto
  has_many_attached :dconvenios
end
