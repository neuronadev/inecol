class Fuente < ApplicationRecord
  self.table_name='py.fuentes'
  belongs_to :nacionalidad
  belongs_to :lugar
  belongs_to :proyecto

  validates :nomfuente, presence: true
  validates :nacionalidad_id, presence: true
  validates :lugar_id, presence: true
  validates :nomcontacto, presence: true
  validates :emailcontacto, presence: true


end
