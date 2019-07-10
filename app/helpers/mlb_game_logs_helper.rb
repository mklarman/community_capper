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

			if p[:true_rating].nan? == false

				@true_rating.push(p[:true_rating])

			end

			if p[:pen_rating].nan? == false

				@pen_rating.push(p[:pen_rating])

			end

			@avg_pc.push(p[:avg_pitch_count])
			@stamina.push(p[:stamina].to_f)
			@p_pc.push(p[:pen_pitch_count])
			@pen_stamina.push(p[:pen_stamina].to_f)


		end

		@overall = @overall.sort
		@overall = @overall.reverse

		@home_rating = @home_rating.sort
		@home_rating = @home_rating.reverse

		@away_rating = @away_rating.sort
		@away_rating = @away_rating.reverse

		@last_three = @last_three.sort
		@last_three = @last_three.reverse

		@true_rating = @true_rating.sort
		@true_rating = @true_rating.reverse

		@pen_rating = @pen_rating.sort
		@pen_rating = @pen_rating.reverse

		@avg_pc = @avg_pc.sort
		@avg_pc = @avg_pc.reverse

		@stamina = @stamina.sort
		@stamina = @stamina.reverse

		@p_pc = @p_pc.sort

		@pen_stamina = @pen_stamina.sort

		@pitchers_and_ratings.each do |p|

			pitcher = Hash.new
			pitcher[:name] = p[:pitcher]

			overall_r = 0
			home_r = 0
			away_r = 0
			last_three_r = 0
			true_r = 0
			pen_r = 0
			avg_pc = 0
			bp_avg_pc = 0
			p_freq = 0
			bp_freq = 0


			@overall.each do |o|

				overall_r += 1

				if o == p[:overall_rating]

					pitcher[:overall_rating] = p[:overall_rating]
					pitcher[:overall_ranking] = p[:overall_rating]
					pitcher[:overall_ranking] = overall_r.to_s + " of " + @overall.length.to_s


				end


			end

			@home_rating.each do |o|

				home_r += 1

				if o == p[:home_rating]
		
					pitcher[:home_rating] = o
					pitcher[:home_ranking] = home_r.to_s + " of " + @home_rating.length.to_s

				end


			end

			@away_rating.each do |o|

				away_r += 1

				if o == p[:away_rating]

					
					pitcher[:away_rating] = o
					pitcher[:away_ranking] = away_r.to_s + " / " + @away_rating.length.to_s


				end


			end

			@last_three.each do |o|

				last_three_r += 1

				if o == p[:last_three]

						

					
					pitcher[:last_three] = o
					pitcher[:last_three_ranking] = last_three_r.to_s + " of " + @last_three.length.to_s


				end


			end

			@true_rating.each do |o|

				true_r += 1

				if o == p[:true_rating]

							
					pitcher[:true_rating] = o
					pitcher[:true_ranking] = true_r.to_s + " of " + @true_rating.length.to_s


				end


			end

			@pen_rating.each do |o|

				pen_r += 1

				if o == p[:pen_rating]

							
					pitcher[:pen_rating] = o
					pitcher[:pen_ranking] = pen_r.to_s + " of " + @pen_rating.length.to_s


				end


			end

			@avg_pc.each do |o|

				avg_pc += 1

				if o == p[:avg_pitch_count]
				
					pitcher[:avg_pitch_count] = o
					pitcher[:av_pc_ranking] = avg_pc.to_s + " of " + @avg_pc.length.to_s


				end


			end

			@p_pc.each do |o|

				bp_avg_pc += 1

				if o == p[:pen_pitch_count]
				
					pitcher[:pen_pitch_count] = o
					pitcher[:pen_pc_ranking] = bp_avg_pc.to_s + " of " + @p_pc.length.to_s


				end


			end

			@stamina.each do |o|

				p_freq += 1

				if o == p[:stamina].to_f
				
					pitcher[:stamina] = o
					pitcher[:stamina_ranking] = p_freq.to_s + " of " + @stamina.length.to_s


				end


			end

			@pen_stamina.each do |o|

				bp_freq += 1

				if o == p[:pen_stamina].to_f
				
					pitcher[:pen_stamina] = o
					pitcher[:pen_stamina_ranking] = bp_freq.to_s + " of " + @pen_stamina.length.to_s


				end


			end

			@pitcher_details.push(pitcher)

		end

	end
end
