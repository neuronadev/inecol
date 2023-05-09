class Proyecto < ApplicationRecord
    self.table_name='py.proyectos'
    has_many :instituciones
    has_one :fuente
    has_one :participante
end
