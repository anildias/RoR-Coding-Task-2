class ApplicationController < ActionController::Base
	
    protect_from_forgery

	  def after_sign_in_path_for(resource)
		    current_user.reset_authentication_token!
        result_posts_path
    end

	  def get_ip_address
		    if request.remote_ip == '127.0.0.1'
      	   # return ip_address by Hard coded remote address...here returning ip address of 'ernakulam'.
      		 '115.119.59.38'
           
      	else
            
      		  request.remote_ip
    	  end
	  end
end
