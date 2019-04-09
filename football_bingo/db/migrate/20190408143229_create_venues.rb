class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.belongs_to :game, index: true
      t.string :gameid
      t.date :date
      t.integer :attend
      t.string :location
      t.timestamps
    end
  end
end
