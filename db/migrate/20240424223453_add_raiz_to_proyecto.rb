class AddRaizToProyecto < ActiveRecord::Migration[7.0]
  def change
    add_column :proyectos, :raiz, :integer
  end
end
