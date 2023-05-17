class Meta < ApplicationRecord
  self.table_name='py.metas'
  belongs_to :proyecto
  has_rich_text :objetivo
  has_rich_text :esperado
  has_rich_text :impacto

end
