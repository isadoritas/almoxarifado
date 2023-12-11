class Produto < ApplicationRecord
  before_destroy :verify_log, prepend: true

  validate :within_horario_permitido?
  has_many :logs, dependent: :destroy
  validates :nome, presence: true, uniqueness: { message: "Já está em uso. Escolha outro nome." }
  validates :quantidade, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def update_with_log(user, params)
    quantidade_anterior, nome_anterior = self.quantidade, self.nome
    #1- tenta atualizar o objeto
    #2- verifica se houve alteração
    #3- se sim > true, não > :unchanged, error > false
    if self.update(params)
      if self.saved_changes?
        log_quantidade(user, quantidade_anterior)
        log_nome(user, nome_anterior, params[:nome])
        true
      else
        errors.add(:base, "É necessário que a atualização seja diferente da anterior")
        :unchanged
      end
    else
      false
    end
  end

  def unchanged?(params)
    self.nome == params[:nome] && self.quantidade == params[:quantidade]
  end
  
  def log_quantidade(user, quantidade_anterior)
    quantidade_alterada = self.quantidade - quantidade_anterior
    return if quantidade_alterada == 0
  
    tipo = quantidade_alterada.positive? ? 'entrada' : 'retirada'
    self.add_log(user, tipo, quantidade_alterada)
  end
  
  def log_nome(user, nome_anterior, novo_nome)
    return if novo_nome.blank? || nome_anterior.strip.downcase == novo_nome.strip.downcase
  
    self.add_log(user, 'alteracao_nome', 0, nome_anterior, novo_nome)
  end
  


  def add_log(user, tipo, quantidade_alterada, nome_anterior = nil, novo_nome = nil)
    logs.create(user: user, tipo: tipo, quantidade_alterada: quantidade_alterada, nome_anterior: nome_anterior, novo_nome: novo_nome)
  end

  def show_logs
    logs.order(created_at: :desc).select(:user_id, :tipo, :quantidade_alterada, :created_at, :nome_anterior, :produto_id, :novo_nome)
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

  def within_horario_permitido?
    current_time = Time.now
    if current_time.wday.between?(1, 5) && current_time.hour.between?(9, 18)
      true
    else
      errors.add(:base, "Atualizações apenas de segunda á sexta - 9h ás 18")
    end
  end
end
