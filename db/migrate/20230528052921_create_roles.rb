class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :'us.roles' do |t|
      t.string :nomrol
      t.string :clave

      t.timestamps
    end
  end
end
