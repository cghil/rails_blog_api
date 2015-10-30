class Article < ActiveRecord::Base
	validates :title, :user_id, presence: true
	validates :text, presence: true

	belongs_to :user
end