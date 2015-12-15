class Api::V1::AnswersController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :destroy]
	respond_to :json
	
	def index
		question = Question.find(params[:question_id])
		answers = question.answers
		render json: answers
	end

	def create
		answer = Answer.new(answer_params)
		user = User.find(params[:answer][:user_id])
		username = user.username
		answer.author = username
		if answer.save
			render json: answer
		else
			render json: {errors: answer.errors}, status: 422
		end
	end

	def destroy
		user = User.find_by(auth_token: request.headers['Authorization'])
		answer = Answer.find(params[:id])
		if user.id == answer.user_id
			answer.destroy
			head 204
		else
			render json: {errors: 'Could NOT delete answer... Server Error'}, status: 422
		end
	end

	private

		def answer_params
			params.require(:answer).permit(:question_id, :body, :user_id)
		end
end
