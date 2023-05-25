class AddObjetivoToMeta < ActiveRecord::Migration[7.0]
  def change
    add_column :metas, :objetivo, :text
  end
end
