class AddOverheadToProyecto < ActiveRecord::Migration[7.0]
  def change
    add_column :proyectos, :overhead, :boolean
  end
end
