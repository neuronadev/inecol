class CreateValidaciones < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.validaciones' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.references :evaluador, null: false, foreign_key: true
      t.references :tvalidacion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
