class PostsController < ApplicationController

	respond_to :json, :html, :xml
	
 	def index
		
	end
 	
	def result
		@user = User.find(current_user.id)
		render :json => { [:email] => @user.email, [:password] => @user.encrypted_password, [:auth_token] => @user.authentication_token }	
	end
end
