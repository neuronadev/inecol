class Academico < ApplicationRecord
  self.table_name='rh.academicos'
  belongs_to :red
  belongs_to :tacademico
  belongs_to :nivel
  belongs_to :convocatoria
  belongs_to :categoria
  belongs_to :persona
end
