class Item < ApplicationRecord
  self.table_name = 'py.items'
  belongs_to :periodo
  belongs_to :proyecto
end
