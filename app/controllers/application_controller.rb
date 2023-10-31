class ApplicationController < ActionController::API
  def authentications
    decode_data = decode_user_data(request.headers["token"])
    user_data=decode_data[0]['user_data'] unless !decode_data
    user = User.find(id: @user_data)
    @abc=user.id
    if abc
      return true
    else
      render json: {message: "invalid credentials"}
    end
  end

  def encode_user_data(payload)
     JWT.encode(payload, 'SECRET', "HS256")
  end


  def decode_user_data(token)
    JWT.decode(token, 'SECRET', true, { algorithm: "HS256" })
  rescue JWT::DecodeError => e
    puts e
  end

  private

  def current_user
    if @abc
      @current_user ||= User.find(@abc)
    end
  end
end
