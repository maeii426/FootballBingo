class CreateCardsandChips < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :cardid
      t.string :b11
      t.string :b12
      t.string :b13
      t.string :b21
      t.string :b22
      t.string :b23
      t.string :b31
      t.string :b32
      t.string :b33
      
      t.timestamps
    end
 
    create_table :chips do |t|
      t.string :chipid
      t.string :conditional
      t.string :argument
      t.float :value
      
      t.timestamps
    end
 
    # hardcoded relation with the 'b' values in the cards table
    # create_table :cards_chips, id: false do |t|
    #   t.belongs_to :card, index: true
    #   t.belongs_to :chip, index: true
    # end
  end
end
