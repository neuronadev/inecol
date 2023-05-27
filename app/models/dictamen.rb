class Dictamen < ApplicationRecord
  self.table_name = 'py.dictamenes'
  belongs_to :proyecto

  has_rich_text :txtdictamen
  has_one_attached :docdictamen
end
