module WelcomeHelper

	def get_todays_matchups

		@current_matchups = []

		Matchup.all.each do |m|

			if m.date == @my_date

				@current_matchups.push(m)

			end

		end


	end

	def get_stars

		@stars = []
		@star_users = []
		@star_situations = []

		current_user.tags.each do |t|

			@star_info = Hash.new

			@star_info[:user_id] = t.star_id
			@star_info[:situation] = t.situation

			@stars.push(@star_info)


		end

		@stars.each do |s|

			Users.all.each do |u|

				if s.class == Hash

					if s[:user_id] == u.id.to_s

						u.selections.each do |sel|

							if s[:situation] == sel.situation

								@star_situations.push(sel)


							end

						end


					end


				end


			end


		end

	end

	def sort_stars

		@faders = []

		current_user.tags.each do |t|

			star_situations.each do |s|

				@current_matchups.each do |m|

					if s.matchup_id == m.id.to_s

						if t.star_id == s.user_id

							if t.situation == s.situation

								if t.brand == "fade"

									@fade_picks = Hash.new

									@fade_picks[:user_id] = t.star_id
									@fade_picks[:selection] = s.pick

									@faders.push(@fade_picks)

								else

									@follow_picks = Hash.new

									@follow_picks[:user_id] = t.star_id
									@follow_picks[:selection] = s.pick

									@followers.push(@follow_picks)

								end

							end

						end

					end


				end

			end

		end

	end

	def count_star_picks

		@pick_holder = []
		@counted_faders = []
		@counted_followers = []
		@follower_picks = []

		@faders.each do |f|

			if f.class == Hash

				@pick_holder.push(f[:selection])

			end

		end

		@pick_holder.uniq.each do |f|

			count = 0

			@pick_holder.each do |p|

				if f == p

					count += 1


				end


			end

			@pick_count = Hash.new

			@pick_count[:pick] = f
			@pick_count[:count] = count

			@counted_faders.push(@pick_count)


		end

		@followers.each do |f|

			if f.class == Hash

				@follower_picks.push(f[:selection])

			end

		end

		@follower_picks.uniq.each do |p|

			count = 0

			@follower_picks.each do |f|

				if p == f

					count += 1

				end


			end

			@pick_count = Hash.new

			@pick_count[:pick] = p
			@pick_count[:count] = count

			@counted_followers.push(@pick_count)


		end

	end



end
