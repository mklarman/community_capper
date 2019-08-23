module NflGameLogsHelper

	def make_pro_team_objects

		Team.all.each do |t|

			if t.sport == "NFL"

				nfl_team = Hash.new

				nfl_team[:id] = t.id
				nfl_team[:team_name] = t.matchup_abbr
				nfl_team[:division] = t.div_or_conf
				nfl_team[:game_logs] = t.nfl_game_logs

				@pro_teams.push(nfl_team)


			end


		end

	end

	def calc_pro_stats

		@pro_teams.each do |cfb|

			rush_for = 0
			rush_ag = 0
			run_plays_for = 0
			run_plays_ag = 0
			pass_plays_for = 0
			pass_plays_ag = 0
			pass_for = 0
			pass_ag = 0
			plays_for = 0
			plays_ag = 0
			to_for = 0
			opp_to = 0
			sacks = 0
			sacks_ag = 0
			sc_plays = 0
			sc_plays_ag = 0
			points_for = 0
			points_ag = 0
			wins = 0
			losses = 0
			games = 0

			cfb[:game_logs].each do |c|

				rush_for += c.rush_yards_for.to_f
				run_plays_for += c.run_plays.to_f
				run_plays_ag += c.run_plays_against.to_f
				pass_plays_ag += c.pass_plays_against.to_f
				pass_plays_for += c.pass_plays.to_f
				rush_ag += c.rush_yards_against.to_f
				pass_for += c.pass_yards_for.to_f
				pass_ag += c.pass_yards_against.to_f
				plays_for += c.plays_for.to_f
				plays_ag += c.plays_against.to_f
				to_for += c.turn_overs.to_f
				opp_to += c.opp_turn_overs.to_f
				sacks += c.sacks_for.to_f
				sacks_ag += c.sacks_against.to_f
				sc_plays += c.scoring_plays_for.to_f
				sc_plays_ag += c.scoring_plays_against.to_f
				points_for += c.score.to_f
				points_ag += c.opp_score.to_f

				if c.spread_result == "win"

					wins += 1

				elsif c.spread_result == "loss"

					losses += 1

				end

				games = cfb[:game_logs].length

				cfb[:rush_yards_for] = rush_for
				cfb[:run_plays_for] = run_plays_for
				cfb[:run_plays_ag] = run_plays_ag
				cfb[:pass_plays_ag] = pass_plays_ag
				cfb[:pass_plays_for] = pass_plays_for
				cfb[:rush_yards_ag] = rush_ag
				cfb[:pass_yards_for] = pass_for
				cfb[:pass_yards_ag] = pass_ag
				cfb[:plays_for] = plays_for
				cfb[:plays_ag] = plays_ag
				cfb[:turn_overs] = to_for
				cfb[:opp_turn_overs] = opp_to
				cfb[:sacks] = sacks
				cfb[:sacks_ag] = sacks_ag
				cfb[:scoring_plays_for] = sc_plays
				cfb[:scoring_plays_ag] = sc_plays_ag
				cfb[:points_for] = points_for
				cfb[:points_ag] = points_ag
				cfb[:wins] = wins
				cfb[:losses] = losses
				cfb[:games] = games
				cfb[:run_plays_per_game] = (cfb[:run_plays_for] / games.to_f).round(2)
				cfb[:run_plays_ag_per_game] = (cfb[:run_plays_ag] / games.to_f).round(2)
				cfb[:pass_plays_ag_per_game] = (cfb[:pass_plays_ag] / games.to_f).round(2)
				cfb[:pass_plays_per_game] = (cfb[:pass_plays_for] / games.to_f).round(2)
				cfb[:rush_yards_per_game] = (cfb[:rush_yards_for] / games.to_f).round(2)
				cfb[:pass_yards_per_game] = (cfb[:pass_yards_for] / games.to_f).round(2)
				cfb[:pass_yards_ag_per_game] = (cfb[:pass_yards_ag] / games.to_f).round(2)
				cfb[:rush_yards_ag_per_game] = (cfb[:rush_yards_ag] / games.to_f).round(2)
				cfb[:plays_per_game] = (cfb[:plays_for] / games.to_f).round(2)
				cfb[:plays_ag_per_game] = (cfb[:plays_ag] / games.to_f).round(2)
				cfb[:plus_minus] = cfb[:turn_overs] - cfb[:opp_turn_overs]
				cfb[:sacks_per_game] = (cfb[:sacks] / games.to_f).round(2)
				cfb[:sacks_ag_per_game] = (cfb[:sacks_ag] / games.to_f).round(2)
				cfb[:scoring_plays_per_game] = (cfb[:scoring_plays_for] / games.to_f).round(2)
				cfb[:scoring_plays_ag_per_game] = (cfb[:scoring_plays_ag] / games.to_f).round(2)
				cfb[:scoring_diff] = cfb[:points_for] - cfb[:points_ag]
				cfb[:record] = cfb[:wins].to_s + " - " + cfb[:losses].to_s

				@test1.push(cfb[:run_plays_per_game])
				
			end

		end

	end

	def sort_for_pro_rankings

		@pro_teams.each do |cfb|

			@rush_yards_per_game.push(cfb[:rush_yards_per_game]) unless cfb[:rush_yards_per_game].nil?
			@run_plays_per_game.push(cfb[:run_plays_per_game]) unless cfb[:run_plays_per_game].nil?
			@run_plays_ag_per_game.push(cfb[:run_plays_ag_per_game]) unless cfb[:run_plays_ag_per_game].nil?
			@pass_plays_per_game.push(cfb[:pass_plays_per_game]) unless cfb[:pass_plays_per_game].nil?
			@pass_plays_ag_per_game.push(cfb[:pass_plays_ag_per_game]) unless cfb[:pass_plays_ag_per_game].nil?
			@rush_yards_ag_per_game.push(cfb[:rush_yards_ag_per_game]) unless cfb[:rush_yards_ag_per_game].nil?
			@pass_yards_per_game.push(cfb[:pass_yards_per_game]) unless cfb[:pass_yards_per_game].nil?
			@pass_yards_ag_per_game.push(cfb[:pass_yards_ag_per_game]) unless cfb[:pass_yards_ag_per_game].nil?
			@plays_per_game.push(cfb[:plays_per_game]) unless cfb[:plays_per_game].nil?
			@plays_ag_per_game.push(cfb[:plays_ag_per_game]) unless cfb[:plays_ag_per_game].nil?
			@plus_minus.push(cfb[:plus_minus]) unless cfb[:plus_minus].nil?
			@sacks_per_game.push(cfb[:sacks_per_game]) unless cfb[:sacks_per_game].nil?
			@sacks_ag_per_game.push(cfb[:sacks_ag_per_game]) unless cfb[:sacks_ag_per_game].nil?
			@scoring_plays_per_game.push(cfb[:scoring_plays_per_game]) unless cfb[:scoring_plays_per_game].nil?
			@scoring_plays_ag_per_game.push(cfb[:scoring_plays_ag_per_game]) unless cfb[:scoring_plays_ag_per_game].nil?
			@scoring_diff.push(cfb[:scoring_diff]) unless cfb[:scoring_diff].nil?
			@wins.push(cfb[:wins]) unless cfb[:wins].nil?

		end


		@run_plays_per_game = @run_plays_per_game.sort

		@run_plays_per_game = @run_plays_per_game.reverse



		@run_plays_ag_per_game = @run_plays_ag_per_game.sort

		@pass_plays_per_game = @pass_plays_per_game.sort   
		@pass_plays_per_game = @pass_plays_per_game.reverse 

		@pass_plays_ag_per_game = @pass_plays_ag_per_game.sort  
		
		@rush_yards_per_game = @rush_yards_per_game.sort
		@rush_yards_per_game = @rush_yards_per_game.reverse

		@rush_yards_ag_per_game = @rush_yards_ag_per_game.sort

		@pass_yards_per_game = @pass_yards_per_game.sort
		@pass_yards_per_game = @pass_yards_per_game.reverse

		@pass_yards_ag_per_game = @pass_yards_ag_per_game.sort

		@plays_per_game = @plays_per_game.sort
		@plays_per_game = @plays_per_game.reverse

		@plays_ag_per_game = @plays_ag_per_game.sort

		@plus_minus = @plus_minus.sort
		@plus_minus = @plus_minus.reverse


		@sacks_per_game = @sacks_per_game.sort
		@sacks_per_game = @sacks_per_game.reverse

		@sacks_ag_per_game = @sacks_ag_per_game.sort

		@scoring_plays_per_game = @scoring_plays_per_game.sort
		@scoring_plays_per_game = @scoring_plays_per_game.reverse

		@scoring_plays_ag_per_game = @scoring_plays_ag_per_game.sort

		@scoring_diff = @scoring_diff.sort
		@scoring_diff = @scoring_diff.reverse

		@wins = @wins.sort
		@wins = @wins.reverse

	end

	def create_pro_standings

		@rush_yards_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:rush_yards_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@rush_yards_per_game.index(r) + 1).to_s + "."
					rush_standings[:rush_yards_per] = r

					@rush_for.push(rush_standings) unless @rush_for.include?(rush_standings)


				end


			end


		end

		@pass_yards_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:pass_yards_per_game] == r

					pass_standings = Hash.new
					pass_standings[:team] = cfb[:team_name]
					pass_standings[:position] = (@pass_yards_per_game.index(r) + 1).to_s + "."
					pass_standings[:pass_yards_per] = r

					@pass_for.push(pass_standings) unless @pass_for.include?(pass_standings)


				end


			end


		end

		@pass_yards_ag_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:pass_yards_ag_per_game] == r

					pass_standings = Hash.new
					pass_standings[:team] = cfb[:team_name]
					pass_standings[:position] = (@pass_yards_ag_per_game.index(r) + 1).to_s + "."
					pass_standings[:pass_yards_ag_per] = r

					@pass_ag.push(pass_standings) unless @pass_ag.include?(pass_standings)


				end


			end


		end

		@rush_yards_ag_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:rush_yards_ag_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@rush_yards_ag_per_game.index(r) + 1).to_s + "."
					rush_standings[:rush_yards_ag_per] = r

					@rush_ag.push(rush_standings) unless @rush_ag.include?(rush_standings)


				end


			end


		end

		@run_plays_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:run_plays_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@run_plays_per_game.index(r) + 1).to_s + "."
					rush_standings[:run_plays_per_game] = r

					@run_pl_for.push(rush_standings) unless @run_pl_for.include?(rush_standings)


				end


			end


		end

		@run_plays_ag_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:run_plays_ag_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@run_plays_ag_per_game.index(r) + 1).to_s + "."
					rush_standings[:run_plays_ag_per_game] = r

					@run_pl_ag.push(rush_standings) unless @run_pl_ag.include?(rush_standings)


				end


			end


		end

		@pass_plays_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:pass_plays_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@pass_plays_per_game.index(r) + 1).to_s + "."
					rush_standings[:pass_plays_per_game] = r

					@pass_pl_for.push(rush_standings) unless @pass_pl_for.include?(rush_standings)


				end


			end


		end

		@pass_plays_ag_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:pass_plays_ag_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@pass_plays_ag_per_game.index(r) + 1).to_s + "."
					rush_standings[:pass_plays_ag_per_game] = r

					@pass_pl_ag.push(rush_standings) unless @pass_pl_ag.include?(rush_standings)


				end


			end


		end

		@plays_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:plays_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@plays_per_game.index(r) + 1).to_s + "."
					rush_standings[:plays_per_game] = r

					@plays_for.push(rush_standings) unless @plays_for.include?(rush_standings)


				end


			end


		end

		@plays_ag_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:plays_ag_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@plays_ag_per_game.index(r) + 1).to_s + "."
					rush_standings[:plays_ag_per_game] = r

					@plays_ag.push(rush_standings) unless @plays_ag.include?(rush_standings)


				end


			end


		end

		@plus_minus.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:plus_minus] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@plus_minus.index(r) + 1).to_s + "."
					rush_standings[:plus_minus] = r

					@pl_min.push(rush_standings) unless @pl_min.include?(rush_standings)


				end


			end


		end

		@sacks_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:sacks_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@sacks_per_game.index(r) + 1).to_s + "."
					rush_standings[:sacks_per_game] = r

					@sacks_for.push(rush_standings) unless @sacks_for.include?(rush_standings)


				end


			end


		end

		@sacks_ag_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:sacks_ag_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@sacks_ag_per_game.index(r) + 1).to_s + "."
					rush_standings[:sacks_ag_per_game] = r

					@sacks_ag.push(rush_standings) unless @sacks_ag.include?(rush_standings)


				end


			end


		end

		@scoring_plays_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:scoring_plays_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@scoring_plays_per_game.index(r) + 1).to_s + "."
					rush_standings[:scoring_plays_per_game] = r

					@sc_pl_for.push(rush_standings) unless @sc_pl_for.include?(rush_standings)


				end


			end


		end

		@scoring_plays_ag_per_game.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:scoring_plays_ag_per_game] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@scoring_plays_ag_per_game.index(r) + 1).to_s + "."
					rush_standings[:scoring_plays_ag_per_game] = r

					@sc_pl_ag.push(rush_standings) unless @sc_pl_ag.include?(rush_standings)


				end


			end


		end

		@scoring_diff.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:scoring_diff] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@scoring_diff.index(r) + 1).to_s + "."
					rush_standings[:scoring_diff] = r

					@score_diff.push(rush_standings) unless @score_diff.include?(rush_standings)


				end


			end


		end

		@wins.each do |r|

			@pro_teams.each do |cfb|

				if cfb[:wins] == r

					rush_standings = Hash.new
					rush_standings[:team] = cfb[:team_name]
					rush_standings[:position] = (@wins.index(r) + 1).to_s + "."
					rush_standings[:record] = cfb[:record]

					@record.push(rush_standings) unless @record.include?(rush_standings)


				end


			end


		end

	end
end
