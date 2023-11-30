class Saida < ApplicationRecord
  belongs_to :produto
  belongs_to :user, class_name: 'User'
end
