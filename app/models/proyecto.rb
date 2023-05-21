class Proyecto < ApplicationRecord
    self.table_name='py.proyectos'
    has_many :instituciones
    accepts_nested_attributes_for :instituciones, reject_if: :all_blank, allow_destroy: true

    belongs_to :clasificacion
    belongs_to :medio
    belongs_to :linea
    has_one :fuente
    has_one :participante
    has_one :presupuesto
    has_one :recurso
    has_one :meta

    has_one :mconvocatoria
    accepts_nested_attributes_for :mconvocatoria, reject_if: :all_blank, allow_destroy: true

    has_many :protocolos
    accepts_nested_attributes_for :protocolos, reject_if: :all_blank, allow_destroy: true

    has_many :convenios
    accepts_nested_attributes_for :convenios, reject_if: :all_blank, allow_destroy: true
    
    has_many :etapas
    has_many :protocolos
    has_many :convenios
end
