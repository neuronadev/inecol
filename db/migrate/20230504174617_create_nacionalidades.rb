class CreateNacionalidades < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.nacionalidades' do |t|
      t.string :nomnacionalidad
      t.string :clave, limit: 3

      t.timestamps
    end
  end
end
