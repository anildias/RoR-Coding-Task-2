class PlacesController < ApplicationController

	def place
		
		if request.get?
			render :json => { :response => "invalid request ....try post" } 
		else
			category = params[:category]
			if params[:authentication_token] and params[:category]
				begin
					user = User.find_by_authentication_token(params[:authentication_token])
					if user.nil? || params[:authentication_token]=="NULL"
						render :json =>{:data => user, :message => "invalid user attempt" }
					else
=begin
	call get_ip_address() function to get the request ip address or by hard coded ip address.
	and then ip address and category search are passed to function get_locations() inorder to get locations.
=end
					 	client_ip = get_ip_address()
					 	near_by_locations = Place.get_locations(client_ip,category)
					 	if near_by_locations == false
                        	render :json=>{:response=>"unsuccessfull",:message=>"OOOPS !!!! no locations found."}
                    	else 
					 		if near_by_locations.to_a.empty?
					 			render :json=>{:response=>client_ip, :message=>"OOOPS !!!!! no result found try another type"}
					 		else
					 			render :json=>{:response=>near_by_locations, :message=>client_ip}
					 		end	
					 	end
	   				end
			 	rescue Exception => e
			 		render :json => {:data => "Exception caught", :message => e.message}
				end 
			else
				render :json => {:data => nil, :message => "wrong input parameter"}
			end	
   		end
   	end
end
