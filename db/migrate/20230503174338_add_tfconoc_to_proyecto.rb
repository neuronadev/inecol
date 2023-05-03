class AddTfconocToProyecto < ActiveRecord::Migration[7.0]
  def change
    add_column :proyectos, :tfconoc, :boolean
  end
end
