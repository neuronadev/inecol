class CreatePacademicos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.pacademicos' do |t|
      t.references :participante, null: false, foreign_key: true
      t.decimal :porcentaje, precision: 16, scale: 2
      t.boolean :responsable

      t.timestamps
    end
  end
end
