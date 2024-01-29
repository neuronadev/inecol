class CreateContenedores < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.contenedores' do |t|
      t.text :nombre

      t.timestamps
    end
  end
end
