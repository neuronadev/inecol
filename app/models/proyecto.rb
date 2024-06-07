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
    has_many :prorrogas
    has_many :avances
    has_many :informes
    has_many :firmas
    has_one :solicitud

    has_one :mconvocatoria, dependent: :destroy, inverse_of: :proyecto
    accepts_nested_attributes_for :mconvocatoria, reject_if: :all_blank, allow_destroy: true

    #has_one :protocolo #, dependent: :destroy, inverse_of: :proyecto
    #accepts_nested_attributes_for :protocolo, reject_if: :all_blank #, allow_destroy: true
    
    has_one_attached :docprotocolo, dependent: :detach
    has_many_attached :docprotocolos, dependent: :detach

    has_one_attached :dconvocatoria, dependent: :detach
    has_one_attached :planconv, dependent: :detach #Convenio firmado
    has_one_attached :dfiniquito, dependent: :detach #Documento finiquito


    #has_one :convenio #, dependent: :destroy, inverse_of: :proyecto
    #accepts_nested_attributes_for :convenio #, reject_if: :all_blank, allow_destroy: true
    has_many_attached :docconvenios
    has_many_attached :protocolos

    
    has_many :etapas
    has_many :enlaces
    has_many :validaciones

    has_rich_text :commeval
    has_rich_text :txtlogro

    validates :nombre, presence: true
    validates :clasificacion_id, presence: true
    validates :medio_id, presence: true
    validates :linea_id, presence: true
    validates :periodo, presence: true
    #validates :docprotocolo, presence: true
    validates :objetivo, presence: true
    #validates :protocolo, presence: true


    medio = Medio.where(clave:'CONV').first
    validates :mconvocatoria, presence: true, :if => lambda {|attr| medio_id == medio.id  }
    validates :instituciones, presence: true, :if => lambda {|attr| interinst  }

    validate do |proyecto|
         ValProtocolo.new(proyecto).validate
    end
            
    def cap_completo
        p = Proyecto.find(self.id)
        if p.fuente.nil?
               false
        elsif p.participante.nil?
               false
        elsif p.presupuesto.nil?
               false
        elsif p.meta.nil?
               false
        else
               true
        end
    end
    def cap_paso
        p = Proyecto.find(self.id)
        if p.fuente.nil?
               1
        elsif p.participante.nil?
               2
        elsif p.presupuesto.nil?
               3
        elsif !p.recurso.nil?
                5
        elsif p.recurso.nil? && p.meta.nil?
                4
        elsif p.recurso.nil? && !p.meta.nil?                
                6
        else                
               0
        end
    end
end


class ValProtocolo
       def initialize(py)
           @py_data = py 
       end
       def validate
            if !@py_data.docprotocolos.any?
                  @py_data.errors.add :docprotocolos, :invalid, message:"Se requiere el protocolo."
            end
       end
 end