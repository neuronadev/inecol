class CreateSolicitudes < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.solicitudes' do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.date :fecha_sol
      t.date :fecha_lim
      t.string :estado, limit: 1

      t.timestamps
    end
  end
end
