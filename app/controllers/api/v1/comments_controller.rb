class Api::V1::CommentsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :destroy]
	respond_to :json

	def index
		question = Question.find(params[:question_id])
		comments = question.comments
		render json: comments
	end

	def create
		comment = Comment.new(comment_params)
		user = User.find(params[:comment][:user_id])
		gravatar = user.gravatar_url
		comment.author = user.username
		comment.gravatar = gravatar
		if comment.save
			render json: comment
		else
			render json: {errors: comment.errors}, status: 422
		end
	end

	def destroy
		user = User.find_by(auth_token: request.headers['Authorization'])
		comment = Comment.find(params[:id])
		if user.id == comment.user_id
			comment.destroy
			head 204
		else
			render json: {errors: 'Could NOT delete question... Server Error'}, status: 422
		end
	end

	private

		def comment_params
			params.require(:comment).permit(:question_id, :body, :user_id)
		end
end
