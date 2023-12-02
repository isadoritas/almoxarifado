class RemoveProdutoIdFromLogs < ActiveRecord::Migration[7.1]
  def change
    remove_column :logs, :produto_id, :integer
  end
end
