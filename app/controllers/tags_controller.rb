class TagsController < ApplicationController

	def new
		
		@tag = Tag.new

	end

	def create

		tag = Tag.new(tag_params)

		if tag.save!

			redirect_back(fallback_location: users_profile_path)

		else

			redirect_to users_profile_path

		end

	end

	def index

		@tags = Tag.all

	end

	def update

		@tag = Tag.find_by_id(params[:id])

		if @tag.update(tag_params)

			redirect_back(fallback_location: users_profile_path)
		else

			redirect_back(fallback_location: users_search_path)

		end

	end

	private

	def tag_params

		params.require(:tag).permit(:date, :user_id, :star_id, :situation, :brand)

	end	
end


