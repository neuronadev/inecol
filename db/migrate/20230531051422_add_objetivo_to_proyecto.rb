class AddObjetivoToProyecto < ActiveRecord::Migration[7.0]
  def change
    add_column :proyectos, :objetivo, :text
  end
end
