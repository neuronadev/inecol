class AddTpoverheadToProyecto < ActiveRecord::Migration[7.0]
  def change
    add_column :proyectos, :tpoverhead, :integer
  end
end
