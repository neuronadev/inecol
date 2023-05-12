class CreateSolicitados < ActiveRecord::Migration[7.0]
  def change
    create_table :'py.solicitados' do |t|
      t.references :presupuesto, null: false, foreign_key: true
      t.references :capitulo, null: false, foreign_key: true
      t.decimal :monto, precision: 16, scale: 2

      t.timestamps
    end
  end
end
