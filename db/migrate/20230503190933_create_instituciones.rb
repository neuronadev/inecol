class CreateInstituciones < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.instituciones' do |t|
      t.string :nominstitucion

      t.timestamps
    end
  end
end
