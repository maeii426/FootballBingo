class CreateDefenses < ActiveRecord::Migration[5.2]
  def change
    create_table :defenses do |t|
    	t.belongs_to :total, index: true
    	t.integer :tackua
    	t.integer :tacka
    	t.integer :tot_tack    	
    	t.integer :tflua
     	t.integer :tfla
    	t.integer :tflyds
    	t.integer :sacks    	
    	t.integer :sackyds
        t.integer :brup
    	t.integer :qbh
    	t.integer :ff    	
    	t.integer :fr	
    	t.integer :fryds   	
    	t.timestamps
    end
  end
end
