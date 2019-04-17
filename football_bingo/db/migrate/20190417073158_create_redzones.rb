class CreateRedzones < ActiveRecord::Migration[5.2]
  def change
    create_table :redzones do |t|
    	t.belongs_to :total, index: true
    	t.integer :att
    	t.integer :scores
    	t.integer :points
    	t.integer :tdrush
    	t.integer :tdpass
    	t.integer :fgmade
    	t.integer :endfga
    	t.integer :enddowns
    	t.integer :endint
    	t.integer :endfumb
    	t.integer :endhalf
    	t.integer :endgame
    	t.timestamps
    end
  end
end
