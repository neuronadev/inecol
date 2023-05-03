class AddProyectoToInstitucion < ActiveRecord::Migration[7.0]
  def change
    add_reference :instituciones, :proyecto, null: false, foreign_key: true
  end
end
