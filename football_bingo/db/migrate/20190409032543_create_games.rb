class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :game_name
      t.datetime :date
      t.string :instant_winner #these should be relations between users and games
      t.string :whoop_winner
      t.integer :notify_by_email
      t.string :source
      t.string :version
      t.string :generated
      t.string :hometeam
      t.string :visteam
      t.integer :state
      
    end
  end
end
