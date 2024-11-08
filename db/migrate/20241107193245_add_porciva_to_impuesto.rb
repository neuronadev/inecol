class AddPorcivaToImpuesto < ActiveRecord::Migration[7.0]
  def change
    add_column :impuestos, :porc_iva, :decimal, precision: 10, scale: 5
  end
end
