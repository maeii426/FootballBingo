class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :game_name
      t.datetime :date
      t.boolean :instant_winner
      t.boolean :whoop_winner
    end
  end
end
