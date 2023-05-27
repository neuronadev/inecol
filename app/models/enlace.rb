class Enlace < ApplicationRecord
  self.table_name = 'py.enlaces'
  belongs_to :proyecto
  belongs_to :enevento
  has_rich_text :txtcoment

  #validates :txtcoment, presence: true

end