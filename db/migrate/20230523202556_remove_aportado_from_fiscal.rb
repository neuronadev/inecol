class RemoveAportadoFromFiscal < ActiveRecord::Migration[7.0]
  def change
    remove_reference :fiscales, :aportado, null: false, foreign_key: true
  end
end
