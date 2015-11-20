class Question < ActiveRecord::Base
  belongs_to :user
  validates :title, :user_id, :body, presence: true
end
