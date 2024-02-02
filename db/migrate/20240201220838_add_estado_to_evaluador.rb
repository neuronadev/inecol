class AddEstadoToEvaluador < ActiveRecord::Migration[7.0]
  def change
    add_column :evaluadores, :estado, :string, limit: 1
  end
end
