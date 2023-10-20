class AddOrdenToTinforme < ActiveRecord::Migration[7.0]
  def change
    add_column :tinformes, :orden, :integer
  end
end
