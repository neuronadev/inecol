class RemoveAportadoFromEspecie < ActiveRecord::Migration[7.0]
  def change
    remove_reference :especies, :aportado, null: false, foreign_key: true
  end
end
