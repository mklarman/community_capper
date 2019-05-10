class AddInningsToMlbGameLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :mlb_game_logs, :innings, :string
  end
end
