class Produto < ApplicationRecord
    has_many :logs, dependent: :destroy

    validates :nome, presence: true, uniqueness: true
    validates :quantidade, presence: true 

    def add_log(user, tipo, quantidade_alterada)
        logs.create(user: user, tipo: tipo, quantidade_alterada: quantidade_alterada)
    end

    def show_logs
    logs.order(created_at: :desc).select(:user_id, :tipo, :quantidade_alterada, :created_at)
  end

    def self.ransackable_attributes(auth_object = nil)
      ["nome"]
    end
end
