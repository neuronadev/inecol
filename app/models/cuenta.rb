class Cuenta < ApplicationRecord
  self.table_name = 'us.cuentas'
  belongs_to :persona
  belongs_to :usuario
  belongs_to :rol
end
