class UsersController < ApplicationController
  def create
    @user = User.create(name: params[:user][:name], email: params[:user][:email])
  end

  def update
    @user = User.find(params[:id]).update(name: params[:user][:name], email: params[:user][:email])
  end

  def destroy
    @user = User.find(params[:id]).destroy
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
end
