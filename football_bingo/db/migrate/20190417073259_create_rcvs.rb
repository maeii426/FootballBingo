class CreateRcvs < ActiveRecord::Migration[5.2]
  def change
    create_table :rcvs do |t|
    	t.belongs_to :total, index: true
    	t.integer :no
    	t.integer :yds
    	t.integer :td
    	t.integer :long
    	t.timestamps
    end
  end
end
