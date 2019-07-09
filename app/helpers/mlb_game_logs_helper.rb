module MlbGameLogsHelper

	def put_pitchers_on_teams

		@nl_pitchers.each do |n|

			MlbGameLog.all.each do |m|

				if n == m.team_starting_pitcher

					if m.team_name == "Phillies"

						@phillies.push(n) unless @phillies.include?(n)

					elsif m.team_name == "Mets"

						@mets.push(n) unless @mets.include?(n)

					elsif m.team_name == "Braves"

						@braves.push(n) unless @braves.include?(n)

					elsif m.team_name == "Nationals"

						@nationals.push(n) unless @nationals.include?(n)

					elsif m.team_name == "Marlins"

						@marlins.push(n) unless @marlins.include?(n)

					elsif m.team_name == "Cubs"

						@cubs.push(n) unless @cubs.include?(n)

					elsif m.team_name == "Brewers"

						@brewers.push(n) unless @brewers.include?(n)

					elsif m.team_name == "Pirates"

						@pirates.push(n) unless @pirates.include?(n)

					elsif m.team_name == "Reds"

						@reds.push(n) unless @reds.include?(n)

					elsif m.team_name == "Cardinals"

						@cardinals.push(n) unless @cardinals.include?(n)

					elsif m.team_name == "Giants"

						@giants.push(n) unless @giants.include?(n)

					elsif m.team_name == "Padres"

						@padres.push(n) unless @padres.include?(n)

					elsif m.team_name == "Dodgers"

						@dodgers.push(n) unless @dodgers.include?(n)

					elsif m.team_name == "Diamondbacks"

						@dbacks.push(n) unless @dbacks.include?(n)

					elsif m.team_name == "Rockies"

						@rockies.push(n) unless @rockies.include?(n)

					end

				end

			end

		end

	end

	def rank_pitchers

		@pitchers_and_ratings.each do |p|

			if p[:overall_rating].nan? == false

				@overall.push(p[:overall_rating])

			end

			if p[:home_rating].nan? == false

				@home_rating.push(p[:home_rating])

			end

			if p[:away_rating].nan? == false

				@away_rating.push(p[:away_rating])

			end

			if p[:last_three].nan? == false

				@last_three.push(p[:last_three])

			end


		end

		@overall = @overall.sort
		@overall = @overall.reverse

		@home_rating = @home_rating.sort
		@home_rating = @home_rating.reverse

		@away_rating = @away_rating.sort
		@away_rating = @away_rating.reverse

		@last_three = @last_three.sort
		@last_three = @last_three.reverse

		overall_r = 0
		home_r = 0
		away_r = 0
		last_three_r = 0

		@overall.each do |o|

			@pitchers_and_ratings.each do |p|

				if o == p[:overall_rating]

					overall_r += 1

					pl_overall_ranking = Hash.new
					pl_overall_ranking[:player] = p[:pitcher]
					pl_overall_ranking[:overall_rating] = p[:overall_rating]
					pl_overall_ranking[:overall_ranking] = overall_r.to_s + " / " + @overall.length.to_s

					@overall_category.push(pl_overall_ranking)

				end


			end


		end

		@home_rating.each do |o|

			@pitchers_and_ratings.each do |p|

				if o == p[:home_rating]

					home_r += 1

					pl_home_ranking = Hash.new
					pl_home_ranking[:player] = p[:pitcher]
					pl_home_ranking[:home_rating] = o
					pl_home_ranking[:home_ranking] = home_r.to_s + " / " + @home_rating.length.to_s

					@home_category.push(pl_home_ranking)

				end


			end


		end

		@away_rating.each do |o|

			@pitchers_and_ratings.each do |p|

				if o == p[:away_rating]

					away_r += 1

					pl_away_ranking = Hash.new
					pl_away_ranking[:player] = p[:pitcher]
					pl_away_ranking[:away_rating] = o
					pl_away_ranking[:away_ranking] = away_r.to_s + " / " + @away_rating.length.to_s

					@away_category.push(pl_away_ranking)

				end


			end


		end

		@last_three.each do |o|

			@pitchers_and_ratings.each do |p|

				if o == p[:last_three]

					last_three_r += 1

					pl_last_three_ranking = Hash.new
					pl_last_three_ranking[:player] = p[:pitcher]
					pl_last_three_ranking[:last_three] = o
					pl_last_three_ranking[:last_three_ranking] = last_three_r.to_s + " / " + @last_three.length.to_s

					@last_three_category.push(pl_last_three_ranking)

				end


			end


		end


	end
end
