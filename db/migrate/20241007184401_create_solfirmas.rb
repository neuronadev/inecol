class CreateSolfirmas < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.solfirmas' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.date :fecha_dict
      t.date :fecha_lim
      t.string :estado, limit: 1

      t.timestamps
    end
  end
end
