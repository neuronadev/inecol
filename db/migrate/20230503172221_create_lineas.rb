class CreateLineas < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.lineas' do |t|
      t.string :nomlinea
      t.string :clave, limit: 2

      t.timestamps
    end
  end
end
