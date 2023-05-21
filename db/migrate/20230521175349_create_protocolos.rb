class CreateProtocolos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.protocolos' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.boolean :activo

      t.timestamps
    end
  end
end
