class CreatePestudiantes < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.pestudiantes' do |t|
      t.references :participante, null: false, foreign_key: true
      t.references :nivel, null: false, foreign_key: true
      t.string :nombre

      t.timestamps
    end
  end
end
