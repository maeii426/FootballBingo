class CreatePenalties < ActiveRecord::Migration[5.2]
  def change
    create_table :penalties do |t|
    	t.belongs_to :total, index: true
    	t.integer :no
    	t.integer :yds
    	t.timestamps
    end
  end
end
