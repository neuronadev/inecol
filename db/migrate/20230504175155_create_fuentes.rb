class CreateFuentes < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.fuentes' do |t|
      t.string :nomfuente
      t.references :nacionalidad, null: false, foreign_key: true
      t.references :lugar, null: false, foreign_key: true
      t.references :proyecto, null: false, foreign_key: true
      t.string :nomcontacto
      t.string :emailcontacto

      t.timestamps
    end
  end
end
