class AddPersonaToProyecto < ActiveRecord::Migration[7.0]
  def change
    add_reference :proyectos, :persona, null: false, foreign_key: true
  end
end
