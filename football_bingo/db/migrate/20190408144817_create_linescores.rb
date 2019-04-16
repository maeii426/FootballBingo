class CreateLinescores < ActiveRecord::Migration[5.2]
  def change
    create_table :linescores do |t|
      t.belongs_to :game, index: true
      t.belongs_to :team, index: true
      
      t.integer :prds
      t.integer :score
      t.string :line
      t.timestamps
    end
  end
end
