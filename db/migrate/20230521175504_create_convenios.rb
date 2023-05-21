class CreateConvenios < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.convenios' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.boolean :activo

      t.timestamps
    end
  end
end
