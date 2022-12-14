class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def new
    session[:current_time] = Time.now
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Регистрация прошла успешно"
    else
      flash.now[:alert] = "Вы неправильно заполнили поля регистрации"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Данные пользователя обновлены"
    else
      flash.now[:alert] = "При попытке сохранить пользователя возникли ошибки"
      render :edit
    end
  end

  def destroy
    @user.destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Пользователь удален"
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find_by!(nickname: params[:nickname])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :header_color, :password, :password_confirmation)
  end

  def authorize_user
    redirect_with_alert unless current_user == @user
  end
end
