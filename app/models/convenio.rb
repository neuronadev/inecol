class Convenio < ApplicationRecord
  self.table_name = 'py.convenios'
  belongs_to :proyecto
  has_one_attached :dconvenio
end
