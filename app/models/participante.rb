class Participante < ApplicationRecord
  self.table_name='py.participantes'
  has_many :pacademicos, dependent: :destroy, inverse_of: :participante
  accepts_nested_attributes_for :pacademicos, reject_if: :all_blank, allow_destroy: true
  
  has_many :pestudiantes, dependent: :destroy, inverse_of: :participante
  accepts_nested_attributes_for :pestudiantes, reject_if: :all_blank, allow_destroy: true

  belongs_to :proyecto
  belongs_to :tparticipante
end