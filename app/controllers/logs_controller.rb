class LogsController < ApplicationController
  def index
    @logs = Log.includes(:produto, :user).all.group_by { |log| log.created_at.to_date }
  end
end
