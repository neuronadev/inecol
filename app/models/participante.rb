class Participante < ApplicationRecord
  self.table_name='py.participantes'
  has_many :pacademicos, dependent: :destroy, inverse_of: :participante
  accepts_nested_attributes_for :pacademicos, reject_if: :all_blank, allow_destroy: true

  has_many :ptecnicos, dependent: :destroy, inverse_of: :participante
  accepts_nested_attributes_for :ptecnicos, reject_if: :all_blank, allow_destroy: true
  
  has_many :pestudiantes, dependent: :destroy, inverse_of: :participante
  accepts_nested_attributes_for :pestudiantes, reject_if: :all_blank, allow_destroy: true, :reject_if => :all_blank

  belongs_to :proyecto
  belongs_to :tparticipante
 
  validates :pacademicos, presence: true
  validates_associated :ptecnicos
  
   validate do |participante|
         TotalPart.new(participante).validate
   end

end

class TotalPart
      def initialize(part)
           @part = part
      end

      def validate
          sum_t = 0.0 
          if !@part.pacademicos.nil?
                  @part.pacademicos.each do |item|
                           if !item.porcentaje.nil? && item._destroy == false
                                 sum_t += item.porcentaje
                           end    
                  end
          end 
          if !@part.ptecnicos.nil?
                  @part.ptecnicos.each do |item|
                           if !item.porcentaje.nil? && item._destroy == false
                                  sum_t += item.porcentaje
                           end    
                  end
          end 
          
          if sum_t != 100.0
               @part.errors.add :base, :invalid, message:"Error en el porcentaje total de participación, este valor debe ser igual a 100%"
          end     
      end
end