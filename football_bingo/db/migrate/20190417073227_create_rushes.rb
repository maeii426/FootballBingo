class CreateRushes < ActiveRecord::Migration[5.2]
  def change
    create_table :rushes do |t|
    	t.belongs_to :total, index: true
    	t.integer :att
    	t.integer :yds
    	t.integer :gain
    	t.integer :loss
    	t.integer :td
    	t.integer :long
    	t.timestamps
    end
  end
end
