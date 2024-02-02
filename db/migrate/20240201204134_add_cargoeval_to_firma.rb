class AddCargoevalToFirma < ActiveRecord::Migration[7.0]
  def change
    add_column :firmas, :cargoeval, :string, limit: 3
  end
end
