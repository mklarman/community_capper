class SelectionsController < ApplicationController

	def create

		selection = Selection.new(selection_params)

		if selection.save

			redirect_back(fallback_location: users_profile_path)

		else

			redirect_back(fallback_location: new_matchup_path)

		end

	end

	private

	def selection_params

		params.require(:selection).permit(:user_id, :matchup_id, :pick, :situation)

	end
end
