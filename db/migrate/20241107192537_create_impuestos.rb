class CreateImpuestos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.impuestos' do |t|
      t.decimal :porc_overhead, precision: 10, scale: 5
      t.decimal :porc_estimulo, precision: 10, scale: 5
      t.string :clave, limit: 3

      t.timestamps
    end
  end
end
