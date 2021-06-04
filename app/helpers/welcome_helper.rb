module WelcomeHelper

	def get_join_date

		@date = current_user.created_at.in_time_zone('Eastern Time (US & Canada)') 
		@day = @date.strftime("%d")
		@month = @date.strftime("%b") 
		@year = @date.strftime("%Y") 


		@my_date = @month << " " << @day << " " <<@year 



	end

	

end
