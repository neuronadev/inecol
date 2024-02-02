class CreateCargos < ActiveRecord::Migration[7.0]
  def change
    create_table :'rh.cargos' do |t|
      t.references :tipocargo, null: false, foreign_key: true
      t.references :persona, null: false, foreign_key: true

      t.timestamps
    end
  end
end
