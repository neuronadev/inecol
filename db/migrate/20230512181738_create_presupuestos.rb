class CreatePresupuestos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.presupuestos' do |t|
      t.decimal :costo, precision: 16, scale: 2
      t.decimal :iva, precision: 16, scale: 2
      t.decimal :tproyecto, precision: 16, scale: 2
      t.decimal :overhead, precision: 16, scale: 2
      t.decimal :estimulo, precision: 16, scale: 2
      t.decimal :tgastos, precision: 16, scale: 2
      t.references :proyecto, null: false, foreign_key: true
      t.references :moneda, null: false, foreign_key: true

      t.timestamps
    end
  end
end
