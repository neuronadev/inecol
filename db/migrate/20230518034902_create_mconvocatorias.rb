class CreateMconvocatorias < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.mconvocatorias' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.string :nomconvocatoria
      t.string :link

      t.timestamps
    end
  end
end
