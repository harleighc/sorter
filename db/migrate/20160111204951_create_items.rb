class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item
      t.decimal :value
      t.string :category
      t.integer :status
      t.decimal :gst
      t.decimal :multiplier
      t.string :date
      t.string :identifier

      t.timestamps null: false
    end
  end
end
