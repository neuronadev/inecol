class RemoveAportadoFromConcurrente < ActiveRecord::Migration[7.0]
  def change
    remove_reference :concurrentes, :aportado, null: false, foreign_key: true
  end
end
