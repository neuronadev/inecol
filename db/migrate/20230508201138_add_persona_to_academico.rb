class AddPersonaToAcademico < ActiveRecord::Migration[7.0]
  def change
    add_reference :academicos, :persona, null: false, foreign_key: true
  end
end
