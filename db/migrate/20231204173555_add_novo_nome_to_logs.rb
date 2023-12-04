class AddNovoNomeToLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :logs, :novo_nome, :string
  end
end
