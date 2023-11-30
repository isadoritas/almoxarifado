class CreateSaidas < ActiveRecord::Migration[7.1]
  def change
    create_table :saidas do |t|
      t.references :produto, null: false, foreign_key: true
      t.integer :quantidade
      t.references :user, null: false, foreign_key: true
      t.datetime :data_saida

      t.timestamps
    end
  end
end
