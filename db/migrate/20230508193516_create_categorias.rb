class CreateCategorias < ActiveRecord::Migration[7.0]
  def change
    create_table :'rh.categorias' do |t|
      t.string :nomcategoria
      t.string :clave, limit: 5

      t.timestamps
    end
  end
end
