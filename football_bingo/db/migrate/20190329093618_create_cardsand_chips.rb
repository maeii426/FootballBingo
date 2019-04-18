class CreateCardsandChips < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      #t.belongs_to :user, index: true
      #t.timestamps
      t.belongs_to :user, index: true 
      t.text :content
      #t.references :user, foreign_key: true
      t.timestamps

    end
    #add_index :cards, [:user_id, :created_at]
  

    create_table :conditions do |t|
      t.belongs_to :translation, index: true
      t.belongs_to :game, index: true
      t.float :value
    end
    
    create_table :translations do |t|
      # t.has_many :conditions, index: true
      # t.has_many :chips, index: true
      #t.index :translationid
      t.string :tag
      t.string :words
      t.bigint :condition_id
      t.bigint :chip_id
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
