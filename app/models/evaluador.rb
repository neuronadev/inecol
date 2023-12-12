class Evaluador < ApplicationRecord
  self.table_name = 'py.evaluadores'
  belongs_to :persona
  has_one :firma
end
