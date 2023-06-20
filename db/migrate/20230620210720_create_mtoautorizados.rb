class CreateMtoautorizados < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.mtoautorizados' do |t|
      t.date :finicio
      t.date :ftermino
      t.decimal :monto, precision: 16, scale: 2
      t.references :proyecto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
