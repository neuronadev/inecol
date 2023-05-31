class Meta < ApplicationRecord
  self.table_name='py.metas'
  belongs_to :proyecto
  
  validates :esperado, presence: true
  validates :impacto, presence: true

end
