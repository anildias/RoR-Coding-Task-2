class RegistrationsController < Devise::RegistrationsController
=begin
  overriding registrations controller create method for sign up
  only post request is valid.
  input : email and password(in md5#)
  output : response "success" and a mail will be send to the specified email. 
  need to actviate that email to sign in.
=end
    def create
          if request.get?
              render :json => { :response => "invalid request ....try post" } 
          else 
              if (params[:email] and params[:password])
		              begin
        	             user = User.create!(:email => params[:email], :password => params[:password])
			                 user.reset_authentication_token!
        	             render :json => {:data => user, :response=> "success", :message=> "Please activate account via email"}
                  rescue Exception => e
        		           render :json => {:data => nil, :message => e.message}        
                  end	
              else
                  render :json => { :response => "wrong parametres" } 
              end
          end 
    end

end 
