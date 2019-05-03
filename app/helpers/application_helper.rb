module ApplicationHelper

	def get_time

  			 @date = Time.now.utc
  			 @date = @date.in_time_zone('Eastern Time (US & Canada)') 
			 @day = @date.strftime("%d")
			 @month = @date.strftime("%b") 
			 @year = @date.strftime("%Y") 


			 @my_date = @day << " " <<@month << " " <<@year 

  	end
end
