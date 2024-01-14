class AddTipoToFirma < ActiveRecord::Migration[7.0]
  def change
    add_column :firmas, :tipo, :string, limit: 15
  end
end
