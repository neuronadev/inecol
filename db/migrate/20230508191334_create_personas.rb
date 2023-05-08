class CreatePersonas < ActiveRecord::Migration[7.0]
  def change
    create_table :'rh.personas' do |t|
      t.string :nombre
      t.string :apaterno
      t.string :amaterno
      t.string :email
      t.references :tpersona, null: false, foreign_key: true

      t.timestamps
    end
  end
end
