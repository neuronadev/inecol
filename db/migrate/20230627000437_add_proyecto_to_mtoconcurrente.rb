class AddProyectoToMtoconcurrente < ActiveRecord::Migration[7.0]
  def change
    add_reference :mtoconcurrentes, :proyecto, null: false, foreign_key: true
  end
end
