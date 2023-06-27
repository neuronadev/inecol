class Mtoconcurrente < ApplicationRecord
    self.table_name = 'py.mtoconcurrentes'

    belongs_to :proyecto

    validates :fecha, presence: true
    validates :monto, presence: true
end
