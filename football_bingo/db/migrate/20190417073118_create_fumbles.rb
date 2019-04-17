class CreateFumbles < ActiveRecord::Migration[5.2]
  def change
    create_table :fumbles do |t|
    	t.belongs_to :total, index: true
    	t.integer :no
    	t.integer :lost

    	t.timestamps
    end
  end
end
