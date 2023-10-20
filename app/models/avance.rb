class Avance < ApplicationRecord
  self.table_name = 'py.avances'
  belongs_to :proyecto
  has_rich_text :txtavance
end
