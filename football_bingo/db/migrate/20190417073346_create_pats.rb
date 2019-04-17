class CreatePats < ActiveRecord::Migration[5.2]
  def change
    create_table :pats do |t|
    	t.belongs_to :total, index: true
    	t.integer :kickatt
    	t.integer :kickmade
    	t.integer :passatt    	
    	t.integer :passmade
    	t.integer :rcvatt
    	t.integer :rcvmade    	
    	t.integer :plus50
    	t.timestamps
    end
  end
end
