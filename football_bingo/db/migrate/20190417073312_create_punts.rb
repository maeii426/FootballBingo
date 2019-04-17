class CreatePunts < ActiveRecord::Migration[5.2]
  def change
    create_table :punts do |t|
    	t.belongs_to :total, index: true
    	t.integer :no
    	t.integer :yds
    	t.integer :long    	
    	t.integer :blkd
    	t.integer :tb
    	t.integer :fc    	
    	t.integer :plus50
    	t.integer :inside20
    	t.float :avg
    	t.timestamps
    end
  end
end
