class CreateRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :records do |t|
      t.decimal :rating, precision: 3, scale: 1, null: false
      t.text :impression
      t.datetime :watched_day, null: false
      t.text :memory_note

      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true
      t.references :theater, foreign_key: true
      t.timestamps
    end
  end
end
