class CreateTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :totals do |t|
      t.belongs_to :game, index: true
      t.belongs_to :team, index: true
      t.string :qtr                   
      
      t.integer :totoff_plays
      t.integer :totoff_yards
      t.float :totoff_avg



      
      t.timestamps
    end
  end
end
