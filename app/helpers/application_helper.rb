module ApplicationHelper

	def get_time

  			 @date = Time.now.utc
  			 @date = @date.in_time_zone('Eastern Time (US & Canada)') 
			 @day = @date.strftime("%d")
			 @month = @date.strftime("%b") 
			 @year = @date.strftime("%Y") 


			 @my_date = @day << " " <<@month << " " <<@year 

  	end

  	def convert_my_date

		@my_month = @my_date[3] + @my_date[4] + @my_date[5] 

		if @my_month == "Jan"

			@my_month = "01"

		elsif @my_month == "Feb"

			@my_month = "02"

		elsif @my_month == "Mar"

			@my_month = "03"

		elsif @my_month == "Apr"

			@my_month = "04"

		elsif @my_month == "May"

			@my_month = "05"

		elsif @my_month == "Jun"

			@my_month = "06"

		elsif @my_month == "Jul"

			@my_month = "07"

		elsif @my_month == "Aug"

			@my_month = "08"

		elsif @my_month == "Sep"

			@my_month = "09"

		elsif @my_month == "Oct"

			@my_month = "10"

		elsif @my_month == "Nov"

			@my_month = "11"

		elsif @my_month == "Dec"

			@my_month = "12"

		end

		@my_date = @my_date[7] + @my_date[8] + @my_date[9] + @my_date[10] + @my_month + @my_date[0] + @my_date[1] 
		@my_date = @my_date.to_i


	end

end
