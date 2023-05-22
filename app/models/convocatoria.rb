class Convocatoria < ApplicationRecord
    self.table_name='rh.convocatorias'

    validates :nomconvocatoria, presence:true
end
