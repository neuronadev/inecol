class Proyecto < ApplicationRecord
    self.table_name='py.proyectos'
    has_many :instituciones
    accepts_nested_attributes_for :instituciones, reject_if: :all_blank, allow_destroy: true
    belongs_to :clasificacion
    has_one :fuente
    has_one :participante
    has_one :presupuesto
end
