class Cargo < ApplicationRecord
  self.table_name="rh.cargos"
  belongs_to :tipocargo
  belongs_to :persona
end
