class CreateMonedas < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.monedas' do |t|
      t.string :nommoneda
      t.string :simbolo, limit: 3
      t.string :clave, limit: 5

      t.timestamps
    end
  end
end
