class Comment < ActiveRecord::Base
	validates :body, :user_id, :question_id, presence: true
  belongs_to :user
  belongs_to :question
end
