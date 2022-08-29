class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[edit update destroy hide unhide]
  before_action :set_question_for_current_user, only: %i[edit update destroy hide unhide]
  after_action :delete_useless_hashtags, only: %i[ update destroy ]

  def create
    @question = Question.create(params.require(:question).permit(:body, :user_id))
    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user.nickname), notice: "Новый вопрос создан!"
    else
      flash[:alert] = "Вы неправильно заполнили вопрос"
      redirect_to new_question_path(nickname: @question.user.nickname)
    end
  end

  def update
    @question.update(params.require(:question).permit(:body, :answer))

    if @question.save
      redirect_to user_path(@question.user.nickname), notice: "Вопрос изменен!"
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
    @questions = Question.order(created_at: :desc).first(10)
    @users = User.order(created_at: :desc).first(10)
  end

  def new
    @user = User.find_by!(nickname: params[:nickname])
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

  def delete_useless_hashtags
    Hashtag.all.each { |hashtag| hashtag.destroy unless hashtag.question_hashtags.any? }
  end
end
