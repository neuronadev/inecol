class AddComentarioToMeta < ActiveRecord::Migration[7.0]
  def change
    add_column :metas, :comentario, :text
  end
end
