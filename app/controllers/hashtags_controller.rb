class HashtagsController < ApplicationController
  def create
  end

  def show
    @hashtag = Hashtag.find_by!(name: params[:name])
    @questions = @hashtag.questions
  end
end
