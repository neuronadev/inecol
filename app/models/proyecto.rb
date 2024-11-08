class Proyecto < ApplicationRecord
    self.table_name='py.proyectos'

    has_many :instituciones, dependent: :destroy, inverse_of: :proyecto
    accepts_nested_attributes_for :instituciones, reject_if: :all_blank, allow_destroy: true

    belongs_to :clasificacion
    belongs_to :medio
    belongs_to :linea
    belongs_to :persona

    has_one :fuente
    has_one :participante
    has_one :presupuesto
    has_one :recurso
    has_one :meta
    has_one :dictamen

    has_one :mconvocatoria, dependent: :destroy, inverse_of: :proyecto
    accepts_nested_attributes_for :mconvocatoria, reject_if: :all_blank, allow_destroy: true

    has_many :protocolos, dependent: :destroy, inverse_of: :proyecto
    accepts_nested_attributes_for :protocolos, reject_if: :all_blank, allow_destroy: true

    has_many :convenios, dependent: :destroy, inverse_of: :proyecto
    accepts_nested_attributes_for :convenios, reject_if: :all_blank, allow_destroy: true
    
    has_many :etapas
    has_many :protocolos
    has_many :convenios
    has_many :enlaces
    has_many :validaciones

    validates :nombre, presence: true
    validates :clasificacion_id, presence: true
    validates :medio_id, presence: true
    validates :linea_id, presence: true
    validates :periodo, presence: true


    medio = Medio.where(clave:'CONV').first
    validates :mconvocatoria, presence: true, :if => lambda {|attr| medio_id == medio.id  }
    validates :instituciones, presence: true, :if => lambda {|attr| interinst  }
        

end
