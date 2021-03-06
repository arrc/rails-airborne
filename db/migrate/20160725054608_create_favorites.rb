class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :favoritable_id
      t.string :favoritable_type
      t.timestamps
      # t.references :favoritable, polymorphic: true, index: true, unique: true
    end
    
    add_index :favorites, [:favoritable_id, :favoritable_type], unique: true
  end
end
