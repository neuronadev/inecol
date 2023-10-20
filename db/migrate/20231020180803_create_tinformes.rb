class CreateTinformes < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.tinformes' do |t|
      t.string :nomtinforme
      t.string :clave, limit: 3

      t.timestamps
    end
  end
end
