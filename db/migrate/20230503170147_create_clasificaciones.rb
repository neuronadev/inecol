class CreateClasificaciones < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.clasificaciones' do |t|
      t.string :nomclasifica
      t.string :clave, limit: 5
      t.string :ovh, limit: 1

      t.timestamps
    end
  end
end
