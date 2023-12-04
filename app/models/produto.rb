class Produto < ApplicationRecord
    before_destroy :verify_log, prepend: true
    has_many :logs, dependent: :destroy

    validates :nome, presence: true, uniqueness: true
    validates :quantidade, presence: true 

    def add_log(user, tipo, quantidade_alterada, nome_anterior = nil, novo_nome = nil)
        logs.create(user: user, tipo: tipo, quantidade_alterada: quantidade_alterada, nome_anterior: nome_anterior, novo_nome: novo_nome)
    end

    def show_logs
      logs.order(created_at: :desc).select(:user_id, :tipo, :quantidade_alterada, :created_at, :nome_anterior, :produto_id)
    end

    def self.ransackable_attributes(auth_object = nil)
      ["nome"]
    end
    private

    def verify_log
      if self.logs.loaded? || self.logs.any?
        errors.add(:base, "Não é possível excluir o produto")
        throw :abort
      end
    end
end
