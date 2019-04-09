class CreateLinescores < ActiveRecord::Migration[5.2]
  def change
    create_table :linescores do |t|
      t.belongs_to :game
      t.integer :prds
      t.integer :score
      t.timestamps
    end
  end
end
