class CreateMedios < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.medios' do |t|
      t.string :nommedio
      t.string :clave, limit: 5

      t.timestamps
    end
  end
end
