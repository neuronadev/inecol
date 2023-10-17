class CreateProrrogas < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.prorrogas' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.date :fecha

      t.timestamps
    end
  end
end
