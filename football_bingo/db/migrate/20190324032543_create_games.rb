class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.datetime :date
      t.string :instant_winner #these should be relations between users and games
      t.string :whoop_winner
      t.string :source
      t.string :version
      t.string :generated
      t.bigint :hometeam_id
      t.bigint :visteam_id
    end
  end
end
