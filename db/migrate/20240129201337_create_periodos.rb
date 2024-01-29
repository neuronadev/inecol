class CreatePeriodos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.periodos' do |t|
      t.references :contenedor, null: false, foreign_key: true
      t.text :nombre
      t.integer :anio
      t.integer :orden

      t.timestamps
    end
  end
end
