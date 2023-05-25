class Meta < ApplicationRecord
  self.table_name='py.metas'
  belongs_to :proyecto
  
  validates :objetivo, presence: true
  validates :esperado, presence: true
  validates :impacto, presence: true

end
