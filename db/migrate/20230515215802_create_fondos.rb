class CreateFondos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.fondos' do |t|
      t.string :nomfondo
      t.string :clave

      t.timestamps
    end
  end
end
