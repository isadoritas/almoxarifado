class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.references :produto, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :tipo
      t.integer :quantidade_alterada

      t.timestamps
    end
  end
end
