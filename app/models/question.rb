class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true
  validates :body, presence: true, length: { maximum: 280 }
  has_many :question_hashtags, dependent: :delete_all
  has_many :hashtags, through: :question_hashtags, source: :hashtag
  after_commit :update_questions_hashtags, on: [:create, :update]

  private

  def update_questions_hashtags
    self.hashtags =
      "#{body} #{answer}".downcase.scan(/#[a-z,а-я,0-9,\-,_]+/i).uniq.map do |hashtag|
        Hashtag.find_or_create_by(name: hashtag)
      end
  end
end
