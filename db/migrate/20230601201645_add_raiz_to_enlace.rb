class AddRaizToEnlace < ActiveRecord::Migration[7.0]
  def change
    add_column :enlaces, :raiz, :integer
  end
end
