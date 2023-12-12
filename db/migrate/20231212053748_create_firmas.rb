class CreateFirmas < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.firmas' do |t|
      t.references :evaluador, null: false, foreign_key: true
      t.references :proyecto, null: false, foreign_key: true
      t.boolean :firmado
      t.text :data

      t.timestamps
    end
  end
end
