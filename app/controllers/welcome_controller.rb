class WelcomeController < ApplicationController

	def users_show


	end

	def user_list

		@tag = Tag.new


	end

	def tag_params

		params.require(:tag).permit(:date, :follower_id, :star_id, :situation, :brand)

	end	
end
