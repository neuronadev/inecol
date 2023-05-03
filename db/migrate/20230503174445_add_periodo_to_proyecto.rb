class AddPeriodoToProyecto < ActiveRecord::Migration[7.0]
  def change
    add_column :proyectos, :periodo, :string
  end
end
