class AddOtroseToDictamen < ActiveRecord::Migration[7.0]
  def change
    add_column :dictamenes, :otrose, :text
  end
end
