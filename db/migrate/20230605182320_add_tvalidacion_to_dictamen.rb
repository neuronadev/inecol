class AddTvalidacionToDictamen < ActiveRecord::Migration[7.0]
  def change
    add_reference :dictamenes, :tvalidacion, null: false, foreign_key: true
  end
end
