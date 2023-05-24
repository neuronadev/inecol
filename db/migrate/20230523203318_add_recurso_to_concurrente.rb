class AddRecursoToConcurrente < ActiveRecord::Migration[7.0]
  def change
    add_reference :concurrentes, :recurso, null: false, foreign_key: true
  end
end
