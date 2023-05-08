class CreateTpersonas < ActiveRecord::Migration[7.0]
  def change
    create_table :'rh.tpersonas' do |t|
      t.string :nomtpersona
      t.string :clave, limit: 5

      t.timestamps
    end
  end
end
