class Financiadora < ApplicationRecord
  self.table_name='py.financiadoras' 
  belongs_to :proyecto
end
