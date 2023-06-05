class CreateDhistoricos < ActiveRecord::Migration[7.0]
  def change
    create_table :dhistoricos do |t|
      t.string :name
      t.string :record_type
      t.bigint :record_id
      t.bigint :blob_id

      t.timestamps
    end
  end
end
