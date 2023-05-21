class CreateEtapas < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.etapas' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.references :tevento, null: false, foreign_key: true

      t.timestamps
    end
  end
end
