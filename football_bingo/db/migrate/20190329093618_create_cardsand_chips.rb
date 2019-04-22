class CreateCardsandChips < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.belongs_to :user, index: true
      #t.index :cardid
      t.belongs_to :game, index: true
      t.timestamps
    end
 
    create_table :chips do |t|
      t.belongs_to :translation
      #t.index :chipid
      t.string :argument
      t.float :value
      
      t.timestamps
    end
    
    create_table :cards_chips, id: false do |t|
      t.belongs_to :card, index: true
      t.belongs_to :chip, index: true
    end
 
    # hardcoded relation with the 'b' values in the cards table
    # create_table :cards_chips, id: false do |t|
    #   t.belongs_to :card, index: true
    #   t.belongs_to :chip, index: true
    # end
  end
end
