class SessionsController < Devise::SessionsController
        
=begin
	overriding sessions controller create method for sign in
	input : email and password (md5#)
	only post request is valid.
	password is again encrypted to md5# to compare with one stored in database.
	for successful sign in auth token is passed.
=end

 	def create
 		if request.get?
 			render :json => { :response => "invalid request ....try post" } 
 		else	
 			if(params[:email] and params[:password])
				begin
            		params[:password] = Digest::MD5.hexdigest(params[:password])
					user = User.find_by_email_and_encrypted_password!(params[:email],params[:password])
					user.reset_authentication_token!
            		if user.confirmation_token.eql?nil
		 				render :json => {:response=> "success", :message=> "Login success. This is your oauth token for all requests until logout.", :auth_token => user.authentication_token }
					else
						render :json => {:response=> "Login unsuccessfull", :message=> "You need to activate email to Sign in"}
					end
				rescue Exception => e
        			render :json => {:data => nil, :message => e.message}
				end
			else
				render :json => {:data => nil, :message => "wrong input parameter"}
			end
		end
	end

=begin
	overriding sessions controller destroy method for sign out
	only post request is valid.
	input : auth token
=end
	def destroy

		if request.get?
			render :json => { :response => "invalid request ....try post" } 
 		else	
			if params[:authentication_token]
            	begin
		            user = User.find_by_authentication_token(params[:authentication_token])
                	if user.nil?
						#render :json =>{:data => user.authentication_token, :message => "Sign OUT" }
						render :json =>{:data => user, :message => "invalid user attempt" }
					else
						user.update_attribute(:authentication_token,"NULL")
                        render :json =>{:response => "success", :message => "signed out successfully"}
					end
				rescue Exception => e
                	render :json => {:data => nil, :message => e.message}
                end
          	else
          		render :json => { :response => "wrong input parameter." } 
          	end	
        end
    end
end  
