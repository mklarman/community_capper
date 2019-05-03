module MatchupsHelper

	def avm_opp(team, sport)

		@all_matchups = []
		@home_fave_under3 = []
		@home_fave_under7 = []
		@home_fave_under10 = []
		@home_fave_under14 = []
		@home_fave_14_or_more = []

		@road_fave_under3 = []
		@road_fave_under7 = []
		@road_fave_under10 = []
		@road_fave_under14 = []
		@road_fave_14_or_more = []

		@road_dog_under3 = []
		@road_dog_under7 = []
		@road_dog_under10 = []
		@road_dog_under14 = []
		@road_dog_14_or_more = []

		@home_dog_under3 = []
		@home_dog_under7 = []
		@home_dog_under10 = []
		@home_dog_under14 = []
		@home_dog_14_or_more = []


		Matchup.each do |m|

			if m.sport == sport

				if m.fav == team || m.dog == team

					@all_matchups.push(m)


				end


			end

		end

		@all_matchups.each do |m|

			if m.fav == team

				if m.fav_field == "home"

					if m.spread < 3

						@home_fave_under3.push(m)


					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@home_fave_under7.push(m)
					

					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@home_fave_under10.push(m)
					

					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@home_fave_under14.push(m)


					else

						@home_fave_14_or_more.push(m)


					end


				else

					if m.spread < 3

						@road_fave_under3.push(m)


					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@road_fave_under7.push(m)
					

					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@road_fave_under10.push(m)
					

					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@road_fave_under14.push(m)


					else

						@road_fave_14_or_more.push(m)


					end

				end

			elsif m.dog == team

				if m.dog_field == "home"

					if m.spread < 3

						@home_dog_under3.push(m)


					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@home_dog_under7.push(m)
					

					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@home_dog_under10.push(m)
					

					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@home_dog_under14.push(m)


					else

						@home_dog_14_or_more.push(m)


					end

				
				else

					if m.spread < 3

						@road_dog_under3.push(m)


					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@road_dog_under7.push(m)
					

					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@road_dog_under10.push(m)
					

					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@road_dog_under14.push(m)


					else

						@road_dog_14_or_more.push(m)


					end


				end

			end

		end

	end
end
