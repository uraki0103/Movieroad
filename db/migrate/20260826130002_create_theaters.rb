class CreateTheaters < ActiveRecord::Migration[8.1]
  def change
    create_table :theaters do |t|
      t.string :theater_name, null: false

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
