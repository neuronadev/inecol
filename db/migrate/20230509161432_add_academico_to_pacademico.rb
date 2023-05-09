class AddAcademicoToPacademico < ActiveRecord::Migration[7.0]
  def change
    add_reference :pacademicos, :academico, null: false, foreign_key: true
  end
end
