class Log < ApplicationRecord
  belongs_to :produto
  belongs_to :user

  attribute :nome_anterior, :string
  attribute :novo_nome, :string
end
