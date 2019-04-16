class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.belongs_to :game, index: true
      t.belongs_to :team, index: true
      
      t.string :name
      t.string :shortname
      t.string :class
      t.timestamps
    end
  end
end
