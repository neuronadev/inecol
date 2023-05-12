class Proyecto < ApplicationRecord
    self.table_name='py.proyectos'
    has_many :instituciones
    accepts_nested_attributes_for :instituciones, reject_if: :all_blank, allow_destroy: true
    has_one :fuente
    has_one :participante
    has_one :presupuesto
end
