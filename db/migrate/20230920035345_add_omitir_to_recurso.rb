class AddOmitirToRecurso < ActiveRecord::Migration[7.0]
  def change
    add_column :recursos, :omitir, :boolean
  end
end
