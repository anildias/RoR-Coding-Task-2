class UserMailer < ActionMailer::Base
  default from: "kannancet@gmail.com"

	def welcome_email(user)

		@user = user
		#@url = "http://example.com/login"
		mail(:to => @user.email, :subject => "Hi welcom to demo1 rails app")
	end
end
