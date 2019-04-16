class CreateDrives < ActiveRecord::Migration[5.2]
  def change
    create_table :drives do |t|
      t.belongs_to :game, index: true
      t.belongs_to :team, index: true
      
      t.string :start
      t.string :end
      t.integer :plays
      t.integer :yards
      t.string :top
      t.string :start_how
      t.string :start_qtr
      t.string :start_time
      t.string :start_spot
      t.string :end_how
      t.string :end_qtr
      t.string :end_time
      t.string :end_spot
      t.timestamps
    end
  end
end
