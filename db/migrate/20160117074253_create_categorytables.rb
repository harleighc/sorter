class CreateCategorytables < ActiveRecord::Migration
  def change
    create_table :categorytables do |t|
      t.string :name
      t.boolean :system
      t.string :owner
      t.integer :user_id
      t.integer :rank

      t.timestamps null: false
    end
  end
end
