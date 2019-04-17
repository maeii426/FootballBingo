class CreateFirstdowns < ActiveRecord::Migration[5.2]
  def change
    create_table :firstdowns do |t|
    	t.belongs_to :total, index: true
    	t.integer :no
    	t.integer :rush
    	t.integer :pass
    	t.integer :penalty
    	t.timestamps
    end
  end
end
