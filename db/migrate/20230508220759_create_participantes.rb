class CreateParticipantes < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.participantes' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.references :participable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
