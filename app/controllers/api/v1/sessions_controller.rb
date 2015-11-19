class Api::V1::SessionsController < ApplicationController
	def create
		user_password = params[:session][:password]
		user_email = params[:session][:email]
		user = user_email.present? && User.find_by(email: user_email)

		if user.nil?
			render json: {errors: 'Email does not exist'}, status: 422
		else
			if user.valid_password? user_password
				sign_in user, store: false
				user.generate_authentication_token!
				user.save
				email = user.email
				auth_token = user.auth_token
				gravatar = user.gravatar_url
				username = user.username
				id = user.id
				render json: {email: email, auth_token: auth_token, id: id, gravatar: gravatar, username: username}, status: 200
			else
				render json: {errors: "Invalid email or password"}, status: 422
			end
		end
	end

	def destroy
		user = User.find_by(auth_token: params[:id])
		puts user
		user.generate_authentication_token!
		user.save
		head 204
	end
end