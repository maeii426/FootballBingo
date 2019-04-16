class CreateFgas < ActiveRecord::Migration[5.2]
  def change
    create_table :fgas do |t|
      t.belongs_to :game, index: true
      t.belongs_to :team, index: true
      
      t.string :kicker
      t.string :qtr
      t.string :clock
      t.integer :distance
      t.boolean :result
      t.timestamps
    end
  end
end
