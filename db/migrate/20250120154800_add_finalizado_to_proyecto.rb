class AddFinalizadoToProyecto < ActiveRecord::Migration[7.0]
  def change
    add_column :proyectos, :finalizado, :boolean
  end
end
