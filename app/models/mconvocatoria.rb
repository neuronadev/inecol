class Mconvocatoria < ApplicationRecord
  self.table_name = 'py.mconvocatorias'
  belongs_to :proyecto
  has_one_attached :dconvocatoria
end
