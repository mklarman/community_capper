class PicksController < ApplicationController

	def create

		pick = Pick.new(pick_params)

		if pick.save!

			redirect_back(fallback_location: users_profile_path)

		else

			redirect_to picks_path

		end

	end

	def index

		@picks = Pick.all
		@pick = Pick.new

	end

	def edit

		@pick = Pick.find_by_id(params[:id])

	end

	def update

		@pick = Pick.find_by_id(params[:id])

		if @pick.update(pick_params)

			redirect_back(fallback_location: users_profile_path)
		else

			redirect_back(fallback_location: users_search_path)

		end

	end

	private

	def pick_params

		params.require(:pick).permit(:sport, :cat, :pick, :line, :reason, :line_movement, :consensus, :result)

	end	
end
