class CreateRedes < ActiveRecord::Migration[7.0]
  def change
    create_table :'rh.redes' do |t|
      t.string :nomred
      t.string :clave

      t.timestamps
    end
  end
end
