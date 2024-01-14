class AddFirmasignToFirma < ActiveRecord::Migration[7.0]
  def change
    add_column :firmas, :firmasign, :text
  end
end
