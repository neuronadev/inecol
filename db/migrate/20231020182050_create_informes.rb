class CreateInformes < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.informes' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.references :tinforme, null: false, foreign_key: true

      t.timestamps
    end
  end
end
