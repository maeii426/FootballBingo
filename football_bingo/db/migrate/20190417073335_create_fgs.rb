class CreateFgs < ActiveRecord::Migration[5.2]
  def change
    create_table :fgs do |t|
    	t.belongs_to :total, index: true
    	t.integer :made
    	t.integer :att
    	t.integer :long    	
    	t.integer :blkd
    	t.timestamps
    end
  end
end
