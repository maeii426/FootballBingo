class CreateKos < ActiveRecord::Migration[5.2]
  def change
    create_table :kos do |t|
    	t.belongs_to :total, index: true
    	t.integer :no
    	t.integer :yds
    	t.integer :ob    	
    	t.integer :tb
    	t.integer :fcyds    	
    	t.timestamps
    end
  end
end
