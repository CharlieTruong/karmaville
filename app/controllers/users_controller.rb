class UsersController < ApplicationController
  def index
      @users = User.by_karma.page(params[:page].to_i)
      @current_page = params[:page].to_i
  end
end
