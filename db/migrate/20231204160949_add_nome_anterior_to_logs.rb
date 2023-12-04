class AddNomeAnteriorToLogs < ActiveRecord::Migration[7.1]
  def change
  add_column :logs, :nome_anterior, :string
  end
end
