class Produto < ApplicationRecord
    has_many :entradas
    has_many :saidas

    validates :nome, presence: true
    validates :quantidade, presence: true 
end
