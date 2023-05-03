class CreateProyectos < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.proyectos' do |t|
      t.text :nombre

      t.timestamps
    end
  end
end
