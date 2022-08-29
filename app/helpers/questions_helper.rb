module QuestionsHelper
  def find_hashtags_from_question(question_id)
    Hashtag.joins(:question_hashtags).where(question_hashtags: { question_id: question_id }).pluck(:name).uniq
  end
end
