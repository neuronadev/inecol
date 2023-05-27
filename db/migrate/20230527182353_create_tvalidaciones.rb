class CreateTvalidaciones < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.tvalidaciones' do |t|
      t.string :nomtvalidacion
      t.string :clave, limit: 5

      t.timestamps
    end
  end
end
