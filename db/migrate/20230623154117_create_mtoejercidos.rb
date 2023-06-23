class CreateMtoejercidos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.mtoejercidos' do |t|
      t.date :fecha
      t.decimal :monto, precision: 16, scale: 2

      t.timestamps
    end
  end
end
