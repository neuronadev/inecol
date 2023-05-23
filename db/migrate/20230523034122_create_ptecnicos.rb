class CreatePtecnicos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.ptecnicos' do |t|
      t.references :participante, null: false, foreign_key: true
      t.decimal :porcentaje, precision: 16, scale: 2

      t.timestamps
    end
  end
end
