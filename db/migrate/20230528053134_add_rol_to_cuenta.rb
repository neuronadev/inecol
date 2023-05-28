class AddRolToCuenta < ActiveRecord::Migration[7.0]
  def change
    add_reference :cuentas, :rol, null: false, foreign_key: true
  end
end
