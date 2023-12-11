class ProdutosController < ApplicationController
  include Pagy::Backend
  
  before_action :authenticate_user!
  before_action :set_produto, only: %i[show edit update destroy]



  # GET /produtos or /produtos.json
  def index
    # @produtos = Produto.all
    @q = Produto.ransack(params[:q])
    @produtos = @q.result(distinct: true)
    @pagy, @produtos = pagy(@q.result, items: 10 )
  end

  # GET /produtos/1 or /produtos/1.json
  def show
    @produto = Produto.find(params[:id])
    @current_user = current_user
  end

  # GET /produtos/new
  def new
    @produto = Produto.new
  end

  # GET /produtos/1/edit
  def edit
  end

  # POST /produtos or /produtos.json
  def create
    @produto = Produto.new(produto_params)

    respond_to do |format|
      if @produto.save
        format.html { redirect_to produto_url(@produto), notice: "Produto was successfully created." }
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1 or /produtos/1.json
  def update
    respond_to do |format|
      result = @produto.update_with_log(current_user, produto_params)
    
      case result
      when :unchanged
        format.html { redirect_to produto_url(@produto), notice: "Nenhuma alteração foi feita." }
        format.json { render :show, status: :ok, location: @produto }
      when true
        format.html { redirect_to produto_url(@produto), notice: "Produto foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1 or /produtos/1.json
  def destroy
    begin
    @produto.destroy!
    flash[:notice] = "Produto foi excluído com sucesso."
    rescue ActiveRecord::RecordNotDestroyed => e
    flash[:alert] = e.record.errors.full_messages.join(', ')
    end

    respond_to do |format|
      format.html { redirect_to produtos_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_produto
    @produto = Produto.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def produto_params
    params.require(:produto).permit(:quantidade, :nome, :email)
  end
end
