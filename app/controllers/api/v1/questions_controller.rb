class Api::V1::QuestionsController < ApplicationController
	before_action :authenticate_with_token!, only: [:update, :destroy, :create]
	respond_to :json

	def index

	end
	
	def show

	end
end
