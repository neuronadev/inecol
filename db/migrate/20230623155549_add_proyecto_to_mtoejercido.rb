class AddProyectoToMtoejercido < ActiveRecord::Migration[7.0]
  def change
    add_reference :mtoejercidos, :proyecto, null: false, foreign_key: true
  end
end
