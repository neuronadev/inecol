class CreateCuentas < ActiveRecord::Migration[7.0]
  def change
    create_table :'us.cuentas' do |t|
      t.references :persona, null: false, foreign_key: true
      t.references :usuario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
