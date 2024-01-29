class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.items' do |t|
      t.references :periodo, null: false, foreign_key: true
      t.text :nombre
      t.references :proyecto, null: false, foreign_key: true
      t.integer :orden

      t.timestamps
    end
  end
end
