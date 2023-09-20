class AddCurrencyToMoneda < ActiveRecord::Migration[7.0]
  def change
    add_column :monedas, :currency, :string, limit: 10
  end
end
