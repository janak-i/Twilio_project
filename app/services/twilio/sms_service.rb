module Twilio

	class SmsService
		TWILIO_ACCOUNT_SID = 'AC899a750c035c55083a5c9a5d2109588a'
		TWILIO_AUTH_TOKEN  =  '0981d415927a9fbee201ec8aec4092e8'
		TWILIO_FROM_PHONE  =  '+16314564853'
		TWILIO_TEST_PHONE  =  '+919340994804'


		def initialize(body, to_phone_number)
			@body=body
			@to_phone_number=to_phone_number
		end


		def call
			@client=Twilio::REST::Client.new(TWILIO_ACCOUNT_SID,TWILIO_AUTH_TOKEN)
			message=@client.messages.create(
				body:@body,
				from: TWILIO_FROM_PHONE,
				to: to(TWILIO_TEST_PHONE)
			)
			puts message.sid
		end

		private

		def to(to_phone_number)
			return TWILIO_TEST_PHONE if Rails.env.development?
			to_phone_number
		end
	end
end
 # Twilio::SmsService.new('hii janak welcome to my personal webpage', '+919340994804').call