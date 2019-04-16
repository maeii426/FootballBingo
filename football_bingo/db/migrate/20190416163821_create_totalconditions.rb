class CreateTotalconditions < ActiveRecord::Migration[5.2]
  def change
    create_table :totalconditions do |t|
      t.belongs_to :total, index: true
      t.belongs_to :translation, index: true
      
      t.float :value
      t.timestamps
    end
  end
end
