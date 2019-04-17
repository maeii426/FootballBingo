class CreatePasses < ActiveRecord::Migration[5.2]
  def change
    create_table :passes do |t|
    	t.belongs_to :total, index: true
    	t.integer :comp
    	t.integer :att
    	t.integer :int
    	t.integer :yds
    	t.integer :td
    	t.integer :long
    	t.integer :sacks
    	t.integer :sackyds
    	t.timestamps
    end
  end
end
