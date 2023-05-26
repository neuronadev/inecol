class CreateEnlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.enlaces' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.references :enevento, null: false, foreign_key: true
      t.string :estado, limit: 1

      t.timestamps
    end
  end
end
