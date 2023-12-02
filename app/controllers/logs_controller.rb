class LogsController < ApplicationController
  def index
    @logs = Log.includes(:produto, :user).order(created_at: :desc)
  end
end
