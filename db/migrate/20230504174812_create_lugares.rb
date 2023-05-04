class CreateLugares < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.lugares' do |t|
      t.string :nomlugar
      t.string :tiponac, limit: 3

      t.timestamps
    end
  end
end
