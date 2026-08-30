class CreateCompanions < ActiveRecord::Migration[8.1]
  def change
    create_table :companions do |t|
      t.string :companion_name, null: false

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
