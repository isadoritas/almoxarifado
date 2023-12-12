class LogsController < ApplicationController
  include Pagy::Backend
  def index
    @q = Log.includes(:produto, :user).ransack(params[:q])
    @logs = @q.result(distinct: true)
    @pagy, @logs = pagy(@q.result, items: 10)
  end
end
