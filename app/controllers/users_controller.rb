class UsersController < ApplicationController
  def index
    if params[:page]
      offset = (params[:page].to_i - 1) * 1000
      @users = User.by_karma.limit(1000).offset(offset)
    else
      @users = User.by_karma.limit(1000)
    end
  end
end
