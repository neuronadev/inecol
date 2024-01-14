class AddClaveToFirma < ActiveRecord::Migration[7.0]
  def change
    add_column :firmas, :clave, :text
  end
end
