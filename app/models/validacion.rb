class Validacion < ApplicationRecord
  self.table_name = 'py.validaciones'
  belongs_to :proyecto
  belongs_to :evaluador
  belongs_to :tvalidacion

  has_rich_text :txtval
end
