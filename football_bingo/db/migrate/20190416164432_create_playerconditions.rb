class CreatePlayerconditions < ActiveRecord::Migration[5.2]
  def change
    create_table :playerconditions do |t|
      t.belongs_to :player, index: true
      t.belongs_to :translation, index: true
      
      t.float :value
      t.timestamps
    end
  end
end
