class AddRecursoToEspecie < ActiveRecord::Migration[7.0]
  def change
    add_reference :especies, :recurso, null: false, foreign_key: true
  end
end
