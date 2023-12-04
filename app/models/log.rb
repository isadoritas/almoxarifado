class Log < ApplicationRecord
  belongs_to :produto
  belongs_to :user

  attribute :nome_anterior, :string

end
