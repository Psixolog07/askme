class User < ApplicationRecord
  has_secure_password
  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w.]+@\w+\.[a-z]+\z/i }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: /\A\w+\z/ }
  validates :header_color, format: { with: /\A#\w{6}/i }

  has_many :questions, dependent: :delete_all
  has_many :posted_questions, class_name: "Question", foreign_key: :author_id, dependent: :nullify
  
  include Gravtastic
gravtastic(secure: true, filetype: :png, size: 100, default: 'retro')

  private

  def downcase_nickname
    nickname&.downcase!
  end
end
