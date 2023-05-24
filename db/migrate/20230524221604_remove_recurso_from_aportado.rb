class RemoveRecursoFromAportado < ActiveRecord::Migration[7.0]
  def change
    remove_reference :aportados, :recurso, null: false, foreign_key: true
  end
end
