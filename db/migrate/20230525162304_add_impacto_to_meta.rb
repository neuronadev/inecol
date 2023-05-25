class AddImpactoToMeta < ActiveRecord::Migration[7.0]
  def change
    add_column :metas, :impacto, :text
  end
end
