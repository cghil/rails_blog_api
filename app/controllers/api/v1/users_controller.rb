class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy, :show, :add_bio]
  respond_to :json

  def show
  	user = User.find(params[:id])
    email = user.email
    gravatar = user.gravatar_url
    id = user.id
    username = user.username
    bio = user.bio
    comments = user.comments
    questions = user.questions
  	render json: {user: {email: email, id: id, gravatar: gravatar, username: username, bio: bio}, comments: comments, questions: questions}
  end

  def create
  	user = User.new(user_params)
  	if user.save
      email = user.email
      auth_token = user.auth_token
      gravatar = user.gravatar_url
      id = user.id
      username = user.username
  		render json: {email: email, auth_token: auth_token, id: id, gravatar: gravatar, username: username} , status: 201
  	else
  		render json: {errors: user.errors}, status: 422
  	end
  end

  def update
    user = current_user

    if user.update(user_params)
      email = user.email
      auth_token = user.auth_token
      gravatar = user.gravatar_url
      id = user.id
      username = user.username
      bio = user.bio
      render json: {email: email, auth_token: auth_token, id: id, gravatar: gravatar, username: username, bio: bio}, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end
  
  def destroy
    current_user.destroy
    head 204
  end

  private

  	def user_params
  		params.require(:user).permit(:email, :password, :password_confirmation, :username, :bio)
  	end

    def user_bio_params
      params.requre(:user).permit(:bio)
    end
end