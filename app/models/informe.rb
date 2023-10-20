class Informe < ApplicationRecord
  self.table_name = 'py.informes'
  belongs_to :proyecto
  belongs_to :tinforme
  has_one_attached :dinforme
end
