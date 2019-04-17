class CreateConversions < ActiveRecord::Migration[5.2]
  def change
    create_table :conversions do |t|
    	t.belongs_to :total, index: true
    	t.integer :thirdconv
    	t.integer :thirdatt
    	t.integer :fourthconv
    	t.integer :fourthatt
    	t.timestamps
    end
  end
end
