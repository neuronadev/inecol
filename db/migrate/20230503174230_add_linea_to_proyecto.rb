class AddLineaToProyecto < ActiveRecord::Migration[7.0]
  def change
    add_reference :proyectos, :linea, null: false, foreign_key: true
  end
end
