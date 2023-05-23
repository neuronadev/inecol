class AddAcademicoToPtecnico < ActiveRecord::Migration[7.0]
  def change
    add_reference :ptecnicos, :academico, null: false, foreign_key: true
  end
end
