class Api::V1::QuestionsController < ApplicationController
	before_action :authenticate_with_token!, only: [ :destroy, :create, :upvote, :downvote]
	respond_to :json

	def index
		questions = Question.all
		render json: questions
	end
	
	def show
		question = Question.find(params[:id])
		comments = question.comments
		user = User.find(question.user_id)
		email = user.email
		username = user.username
		user = {username: username, email: email}
		render json: {question: question, comments: comments, user: user}
	end

	def create
		question = Question.new(question_params)
		id = params[:question][:user_id]
		user = User.find(id)
		question.author = user.username
		if question.save
			render json: question
		else
			render json: {errors: question.errors}, status: 422
		end
	end

	def destroy
		user = User.find_by(auth_token: request.headers['Authorization'])
		question = Question.find(params[:id])
		if user.id == question.user_id
			question.destroy
			head 204
		else
			render json: { errors: "Could NOT delete question... Server Error" }, status: 422
		end
	end

	def upvote
		question = Question.find(params[:id])
		question.votes +=1
	end

	def downvote
		question = Question.find(params[:id])
		question.votes -=1
	end

	private

		def question_params
			params.require(:question).permit(:user_id, :title, :body)
		end
end
