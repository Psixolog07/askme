class Hashtag < ApplicationRecord
  has_many :question_hashtags, dependent: :delete_all
  has_many :questions, through: :question_hashtags, source: :question
  
  scope :top_10_popular_hashtags, -> { includes(:question_hashtags)
    .group(['question_hashtags.hashtag_id, hashtags.name'])
    .order('COUNT(question_hashtags.id) DESC').pluck(:name).uniq.first(10) }
end
