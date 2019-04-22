class CreateGameUser < ActiveRecord::Migration[5.2]
  def change
    create_table :game_users do |t|
      t.belongs_to :game, index: true
      t.belongs_to :user, index: true
    end
  end
end
