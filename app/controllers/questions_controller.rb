class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[edit update destroy hide unhide]
  before_action :set_question_for_current_user, only: %i[edit update destroy hide unhide]

  def create
    @question = Question.create(params.require(:question).permit(:body, :user_id))
    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user), notice: "Новый вопрос создан!"
    else
      flash.now[:alert] = "Вы неправильно заполнили вопрос"
      render :new
    end
  end

  def update
    @question.update(params.require(:question).permit(:body, :answer))

    if @question.save
      redirect_to user_path(@question.user), notice: "Вопрос изменен!"
    else
      flash.now[:alert] = "Вы неправильно заполнили вопрос"
      render :edit
    end
  end

  def destroy
    @user = @question.user
    @question.destroy
    redirect_to user_path(@user), notice: "Вопрос удален!"
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.order(created_at: :desc).last(10)
    @users = User.order(created_at: :desc).last(10)
  end

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def edit
  end

  def hide
    @question.update(hidden: true)
    redirect_to questions_path
  end

  def unhide
    @question.update(hidden: false)
    redirect_to questions_path
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
