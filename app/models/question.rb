class Question < ActiveRecord::Base
  belongs_to :user
  validates :title, :user_id, :body, presence: true
  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
end
