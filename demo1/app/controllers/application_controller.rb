class ApplicationController < ActionController::Base
	
  protect_from_forgery

	def after_sign_in_path_for(resource)
		 current_user.reset_authentication_token!
     	 result_posts_path
  	end

end
