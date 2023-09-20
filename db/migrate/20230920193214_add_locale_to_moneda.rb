class AddLocaleToMoneda < ActiveRecord::Migration[7.0]
  def change
    add_column :monedas, :locale, :string, limit: 20
  end
end
