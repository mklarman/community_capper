# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190510162649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cbb_game_logs", force: :cascade do |t|
    t.string "date"
    t.string "opp"
    t.string "home"
    t.string "spread"
    t.string "possessions_for"
    t.string "possessions_against"
    t.string "field_goals_made_for"
    t.string "field_goals_made_against"
    t.string "three_pointers_made"
    t.string "three_pointers_made_against"
    t.string "points_in_the_paint_for"
    t.string "points_in_the_paint_against"
    t.string "rebounds_for"
    t.string "rebounds_against"
    t.string "assists_for"
    t.string "assists_against"
    t.string "steals_for"
    t.string "steals_against"
    t.string "turn_overs_for"
    t.string "opp_turn_overs"
    t.string "score"
    t.string "opp_score"
    t.string "spread_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cfb_game_logs", force: :cascade do |t|
    t.string "date"
    t.string "home"
    t.string "opp"
    t.string "spread"
    t.string "rush_yards_for"
    t.string "rush_yards_against"
    t.string "pass_yards_for"
    t.string "pass_yards_against"
    t.string "plays_for"
    t.string "plays_against"
    t.string "turn_overs"
    t.string "opp_turn_overs"
    t.string "sacks_for"
    t.string "sacks_against"
    t.string "scoring_plays_for"
    t.string "scoring_plays_against"
    t.string "score"
    t.string "opp_score"
    t.string "spread_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matchups", force: :cascade do |t|
    t.string "date"
    t.string "sport"
    t.string "fav"
    t.string "dog"
    t.string "fav_field"
    t.string "dog_field"
    t.string "spread"
    t.string "fav_ml"
    t.string "dog_ml"
    t.string "total"
    t.string "game_type"
    t.string "field_type"
    t.string "road_start_time"
    t.string "home_start_time"
    t.string "weather"
    t.string "home_d"
    t.string "home_o"
    t.string "road_d"
    t.string "road_o"
    t.string "home_pitcher"
    t.string "away_pitcher"
    t.string "home_score"
    t.string "road_score"
    t.string "winner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mlb_game_logs", force: :cascade do |t|
    t.string "team_id"
    t.string "date"
    t.string "team_name"
    t.string "opp"
    t.string "home"
    t.string "spread"
    t.string "situation"
    t.string "team_starting_pitcher"
    t.string "opp_starting_pitcher"
    t.string "opp_pitcher_throws"
    t.string "team_pitcher_throws"
    t.string "team_starter_pitches"
    t.string "opp_starter_pitches"
    t.string "team_bullpen_picthes"
    t.string "opp_bullpen_picthes"
    t.string "runs_by_opp_starter"
    t.string "runs_by_team_starter"
    t.string "runs_by_opp_bullpen"
    t.string "runs_by_team_bullpen"
    t.string "at_bats_for"
    t.string "at_bats_against"
    t.string "team_hits"
    t.string "team_errors"
    t.string "opp_hits"
    t.string "opp_errors"
    t.string "innings"
    t.string "team_runs"
    t.string "opp_runs"
    t.string "spread_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nba_game_logs", force: :cascade do |t|
    t.string "date"
    t.string "opp"
    t.string "home"
    t.string "spread"
    t.string "possessions_for"
    t.string "possessions_against"
    t.string "field_goals_made_for"
    t.string "field_goals_made_against"
    t.string "three_pointers_made"
    t.string "three_pointers_made_against"
    t.string "points_in_the_paint_for"
    t.string "points_in_the_paint_against"
    t.string "rebounds_for"
    t.string "rebounds_against"
    t.string "assists_for"
    t.string "assists_against"
    t.string "steals_for"
    t.string "steals_against"
    t.string "turn_overs_for"
    t.string "opp_turn_overs"
    t.string "score"
    t.string "opp_score"
    t.string "spread_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nfl_game_logs", force: :cascade do |t|
    t.string "date"
    t.string "home"
    t.string "opp"
    t.string "spread"
    t.string "rush_yards_for"
    t.string "rush_yards_against"
    t.string "pass_yards_for"
    t.string "pass_yards_against"
    t.string "plays_for"
    t.string "plays_against"
    t.string "turn_overs"
    t.string "opp_turn_overs"
    t.string "sacks_for"
    t.string "sacks_against"
    t.string "scoring_plays_for"
    t.string "scoring_plays_against"
    t.string "score"
    t.string "opp_score"
    t.string "spread_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "selections", force: :cascade do |t|
    t.integer "user_id"
    t.integer "matchup_id"
    t.string "pick"
    t.string "situation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "date"
    t.string "user_id"
    t.string "star_id"
    t.string "situation"
    t.string "brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "sport"
    t.string "city_or_school_name"
    t.string "team_name"
    t.string "div_or_conf"
    t.string "matchup_abbr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "username"
    t.string "agent"
    t.boolean "statter", default: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
