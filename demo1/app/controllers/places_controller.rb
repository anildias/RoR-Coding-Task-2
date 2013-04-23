class PlacesController < ApplicationController
=begin

=end

	def place
       if (params[:authentication_token])
        	@is_parameter_value=true
            	begin
                  	user=User.find_by_authentication_token(params[:authentication_token])                     
                  	if user.nil? || params[:authentication_token]=="NULL"
                  		@unauthorised_user=true
                    	respond_to do |format|
   		                    format.html
   		                    format.json{render :json => {:message => "Unauthorised User Attempt"}}
                    	end
                  	else
                    	client_ip=get_ip_address()
                    	category=params[:category]
                    	@locations=Place.get_locations(client_ip,category)
                    if @locations==false
                        	respond_to do |format|
                                format.html
                                format.json{render :json=>{:response=>"failure",:message=>"Sorry, we were not able to locate you."}}
                        	end
                    else 
                        if @locations.to_a.empty?
                          	@is_locations_empty=true
                            respond_to do |format|
                                format.html
                                format.json{render :json=>{:response=>"failure",:message=>"Sorry, no results found"}}
                            end
                        else
                          	@is_locations_empty=false
                            @size=@locations.length
                            respond_to do |format|
   		                        format.html
   		                        format.json{render :json=>{:response=>@locations,:message=>"Success!!"}}
                            end 
                        end
                    end
            	end
            	rescue Exception => e
              		respond_to do |format|
                        format.html
                        format.json{render :json => {:data => nil, :message => e.message} }
              		end    
            	end   
       	else
            respond_to do |format|
                @is_parameter_value=false
                format.html
                format.json{render :json => {:response => "failure", :message => "Invalid Parameter"}}
            end    
       	end
    end
end
