class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.belongs_to :game, index: true
      t.belongs_to :team, index: true
      
      t.string :qtr
      t.string :clock
      t.string :type 
      # type is restricted word, you can't use it as a column name in ActiveRecord models
      t.string :how
      t.string :yds
      t.string :scorer
      t.string :passer
      t.string :patby
      t.string :pattype
      t.string :patres
      t.integer :plays
      t.integer :drive
      t.string :top
      t.integer :vscore
      t.integer :hscore
  #    t.integer :driveindex
      t.timestamps
    end
  end
end
