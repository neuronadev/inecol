class CreateAcademicos < ActiveRecord::Migration[7.0]
  def change
    create_table :'rh.academicos' do |t|
      t.references :red, null: false, foreign_key: true
      t.references :tacademico, null: false, foreign_key: true
      t.references :nivel, null: false, foreign_key: true
      t.references :convocatoria, null: false, foreign_key: true
      t.references :categoria, null: false, foreign_key: true
      t.date :fechaingreso
      t.date :fechabaja
      t.integer :numempleado
      t.string :estado, limit: 2

      t.timestamps
    end
  end
end
