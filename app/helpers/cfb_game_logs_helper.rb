module CfbGameLogsHelper

	def make_team_objects

		Team.all.each do |t|

			if t.sport == "CFB"

				cfb_team = Hash.new

				cfb_team[:id] = t.id
				cfb_team[:team_name] = t.matchup_abbr
				cfb_team[:division] = t.div_or_conf
				cfb_team[:game_logs] = t.cfb_game_logs

				@cfb_teams.push(cfb_team)


			end


		end

	end

	def calc_stats

		@cfb_teams.each do |cfb|

			rush_for = 0
			rush_ag = 0
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


			end


		end


	end

end
