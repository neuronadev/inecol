class CreateAvances < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.avances' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.decimal :porcentaje, precision: 16, scale: 2
      t.date :fecha

      t.timestamps
    end
  end
end
