class CreateTparticipantes < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.tparticipantes' do |t|
      t.string :nomtparticipante
      t.string :clave, limit: 5

      t.timestamps
    end
  end
end
