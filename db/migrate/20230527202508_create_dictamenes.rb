class CreateDictamenes < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.dictamenes' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.string :numregistro

      t.timestamps
    end
  end
end
