class CreateCapitulos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.capitulos' do |t|
      t.string :nomcapitulo
      t.integer :orden

      t.timestamps
    end
  end
end
