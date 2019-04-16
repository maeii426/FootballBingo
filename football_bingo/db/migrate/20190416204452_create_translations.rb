class CreateTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :translations do |t|
      # t.has_many :conditions, index: true
      # t.has_many :chips, index: true
      #t.index :translationid
      t.string :tag
      t.string :words
    end
  end
end
