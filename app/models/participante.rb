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
  
end