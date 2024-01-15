class Dictamen < ApplicationRecord
  self.table_name = 'py.dictamenes'
  belongs_to :proyecto
  belongs_to :tvalidacion

  has_rich_text :txtdictamen
  #has_one_attached :docdictamen
  has_many_attached :docdictamenes

    

end
