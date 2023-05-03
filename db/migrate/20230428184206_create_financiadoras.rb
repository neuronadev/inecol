class CreateFinanciadoras < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.financiadoras' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.text :nomfinanciadora
      t.string :nomcontacto
      t.string :emailcontacto

      t.timestamps
    end
  end
end
