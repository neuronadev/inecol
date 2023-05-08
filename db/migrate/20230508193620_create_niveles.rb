class CreateNiveles < ActiveRecord::Migration[7.0]
  def change
    create_table :'rh.niveles' do |t|
      t.string :nomnivel
      t.string :clave, limit: 5

      t.timestamps
    end
  end
end
