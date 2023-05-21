class CreateTeventos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.teventos' do |t|
      t.string :nomtevento
      t.string :clave, limit: 5

      t.timestamps
    end
  end
end
