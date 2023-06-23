class Mtoejercido < ApplicationRecord
    self.table_name='py.mtoejercidos'
    belongs_to :proyecto

    validates :fecha, presence: true
    validates :monto, presence: true
end
