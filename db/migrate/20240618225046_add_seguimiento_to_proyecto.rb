class AddSeguimientoToProyecto < ActiveRecord::Migration[7.0]
  def change
    add_column :proyectos, :seguimiento, :boolean
  end
end
