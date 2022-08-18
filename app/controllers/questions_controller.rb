class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy hide unhide]

  def create
    @question = Question.create(question_params)

    if @question.save
      redirect_to question_path(@question), notice: "Новый вопрос создан!"
    else
      flash.now[:alert] = "Вы неправильно заполнили вопрос"

      render :new
    end
  end

  def update
    @question.update(question_params)

    if @question.update
      redirect_to question_path(@question), notice: "Вопрос изменен!"
    else
      flash.now[:alert] = "Вы неправильно заполнили вопрос"

      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to questions_path, notice: "Вопрос удален!"
  end

  def show
  end

  def index
    @questions = Question.all
    @question = Question.new
  end

  def new
    @question = Question.new
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

  def question_params
    params.require(:question).permit(:body, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
