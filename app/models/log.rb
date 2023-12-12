class Log < ApplicationRecord
  belongs_to :produto
  belongs_to :user

  attribute :nome_anterior, :string
  attribute :novo_nome, :string

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "nome_anterior", "novo_nome", "quantidade_alterada", "tipo" ]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["produto", "user"]
  end
end
