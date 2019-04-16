class CreateLinescoreconditions < ActiveRecord::Migration[5.2]
  def change
    create_table :linescoreconditions do |t|
      t.belongs_to :linescore, index: true
      t.belongs_to :translation, index: true
      
      t.float :value
      t.timestamps
    end
  end
end
