class CreateEneventos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.eneventos' do |t|
      t.string :nomenevento
      t.string :clave, limit: 5

      t.timestamps
    end
  end
end
