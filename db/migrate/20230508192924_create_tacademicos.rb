class CreateTacademicos < ActiveRecord::Migration[7.0]
  def change
    create_table :'rh.tacademicos' do |t|
      t.string :nomtacademico
      t.string :clave, limit: 5

      t.timestamps
    end
  end
end
