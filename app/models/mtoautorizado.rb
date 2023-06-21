class Mtoautorizado < ApplicationRecord
  self.table_name='py.mtoautorizados'
  belongs_to :proyecto

  validates :finicio, presence: true
  validates :ftermino, presence: true
  validates :monto, presence: true

end
