class CreateAportados < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.aportados' do |t|
      t.references :recurso, null: false, foreign_key: true
      t.references :fondo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
