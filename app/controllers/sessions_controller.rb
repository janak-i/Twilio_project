class SessionsController < ApplicationController
	def sign_up
		user=User.new(user_params)
		if user.save
			message = "Welcome to My App! Your account has been created."
			phone_number = '+919340994804'
			sms_service = Twilio::SmsService.new(message, phone_number)
			sms_service.call
			render json: {'data': user}
		else
			render json: {message: "invalid credentials"}
		end
	end

	def display_users
		users=User.all
		render json: {"users": users}
	end

	def login
		user = User.find_by(email: params[:user][:email])
		if user && user.password == params[:user][:password]
			token = encode_user_data({ user_data: user.id })
			render json: { token: token }
		else
			render json: { message: "invalid credentials" }
		end
	end

	def forgot
		if params[:user][:email].blank?
			render json: { error: "Email not present" }, status: :unprocessable_entity
			return
		end

		user = User.find_by(email: params[:user][:email])
		if user.present?
			user.generate_password_token!
			render json: { status: "ok" }, status: :ok
		else
			render json: { error: ['Email address not found. Please check and try again.'] }, status: :not_found
		end
    end

    def reset
    	token = params[:token].to_s
    	if params[:user][:email].blank?
    		render json: { error: 'Token not present' }, status: :unprocessable_entity
    		return
    	end
    	user = User.find_by(reset_password_token: token)
    	if user.present? && user.password_token_valid?
    		if user.reset_password!(params[:password])
    			render json: { status: 'ok' }, status: :ok
            else
            	render json: { error: user.errors.full_messages }, status: :unprocessable_entity
            end
        else
        	render json: { error: ['Link not valid or expired. Try generating a new link.'] }, status: :not_found
        end
    end

    private

    def user_params
		params.require(:user).permit(:email, :password)
	end
end