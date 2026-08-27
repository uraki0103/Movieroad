class CreateRecordCompanions < ActiveRecord::Migration[8.1]
  def change
    create_table :record_companions do |t|
      t.references :record, null: false, foreign_key: true
      t.references :companion, null: false, foreign_key: true

      t.timestamps
    end

    add_index :record_companions, [:record_id, :companion_id], unique: true
  end
end
