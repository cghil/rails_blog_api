class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy, :show]
  respond_to :json

  def show
  	user = User.find(params[:id])
    email = user.email
    auth_token = user.auth_token
    gravatar = user.gravatar_url
    id = user.id
    username = user.username
  	render json: {email: email, auth_token: auth_token, id: id, gravatar: gravatar, username: username}
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
      render json: {email: email, auth_token: auth_token, id: id, gravatar: gravatar, username: username}, status: 200
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
  		params.require(:user).permit(:email, :password, :password_confirmation, :username)
  	end
end