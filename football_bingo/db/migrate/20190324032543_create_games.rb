class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :gameid
      t.datetime :date
      t.string :instant_winner
      t.string :whoop_winner
    end
  end
end
