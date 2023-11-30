class CreateEntradas < ActiveRecord::Migration[7.1]
  def change
    create_table :entradas do |t|
      t.references :produto, null: false, foreign_key: true
      t.integer :quantidade
      t.references :user, null: false, foreign_key: true
      t.datetime :data_entrada

      t.timestamps
    end
  end
end
