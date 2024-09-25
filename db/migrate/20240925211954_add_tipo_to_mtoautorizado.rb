class AddTipoToMtoautorizado < ActiveRecord::Migration[7.0]
  def change
    add_column :mtoautorizados, :tipo, :string, limit: 2
  end
end
