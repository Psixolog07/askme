class User < ApplicationRecord
  include Gravtastic
  gravtastic(secure: true, filetype: :png, size: 100, default: 'retro')

  before_validation :downcase_nickname
  has_many :questions, dependent: :delete_all
  has_many :posted_questions, class_name: "Question", foreign_key: :author_id, dependent: :nullify
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w.]+@\w+\.[a-z]+\z/i }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: /\A\w+\z/ }
  validates :header_color, format: { with: /\A#\w{6}/i }
  
  private

  def downcase_nickname
    nickname&.downcase!
  end
end
