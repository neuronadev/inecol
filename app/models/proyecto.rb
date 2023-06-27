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
    has_one :mtoautorizado
    has_many :mtoejercidos
    has_one :mtoconcurrente

    has_one :mconvocatoria, dependent: :destroy, inverse_of: :proyecto
    accepts_nested_attributes_for :mconvocatoria, reject_if: :all_blank, allow_destroy: true

    #has_one :protocolo #, dependent: :destroy, inverse_of: :proyecto
    #accepts_nested_attributes_for :protocolo, reject_if: :all_blank #, allow_destroy: true
    has_one_attached :docprotocolo, dependent: :detach
    has_one_attached :dconvocatoria, dependent: :detach

    #has_one :convenio #, dependent: :destroy, inverse_of: :proyecto
    #accepts_nested_attributes_for :convenio #, reject_if: :all_blank, allow_destroy: true
    has_many_attached :docconvenios
    
    has_many :etapas
    has_many :enlaces
    has_many :validaciones

    validates :nombre, presence: true
    validates :clasificacion_id, presence: true
    validates :medio_id, presence: true
    validates :linea_id, presence: true
    validates :periodo, presence: true
    validates :docprotocolo, presence: true
    validates :objetivo, presence: true
    #validates :protocolo, presence: true


    medio = Medio.where(clave:'CONV').first
    validates :mconvocatoria, presence: true, :if => lambda {|attr| medio_id == medio.id  }
    validates :instituciones, presence: true, :if => lambda {|attr| interinst  }
        

end
