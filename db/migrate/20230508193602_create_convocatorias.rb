class CreateConvocatorias < ActiveRecord::Migration[7.0]
  def change
    create_table :'rh.convocatorias' do |t|
      t.string :nomconvocatoria
      t.string :clave, limit: 5

      t.timestamps
    end
  end
end
