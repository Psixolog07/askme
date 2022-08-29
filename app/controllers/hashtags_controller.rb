class HashtagsController < ApplicationController
  def create
  end

  def show
    @hashtag = Hashtag.find(params[:id])
    @questions = @hashtag.questions
  end
end
