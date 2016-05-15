class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.order( last_sign_in_at: :desc)
  end
end
