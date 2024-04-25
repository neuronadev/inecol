class AddModificatorioToProyecto < ActiveRecord::Migration[7.0]
  def change
    add_column :proyectos, :modificatorio, :string, limit: 4
  end
end
