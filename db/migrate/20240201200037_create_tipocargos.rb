class CreateTipocargos < ActiveRecord::Migration[7.0]
  def change
    create_table :'rh.tipocargos' do |t|
      t.string :nomtcargo, limit: 200
      t.string :clave, limit: 3

      t.timestamps
    end
  end
end
