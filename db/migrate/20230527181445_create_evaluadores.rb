class CreateEvaluadores < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.evaluadores' do |t|
      t.references :persona, null: false, foreign_key: true
      t.boolean :evalua

      t.timestamps
    end
  end
end
